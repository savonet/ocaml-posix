open Ctypes
include Posix_getopt_stubs.Def (Posix_getopt_generated_stubs)

type short = char
type long = string * char

type arg =
  [ `None of unit -> unit
  | `Optional of string option -> unit
  | `Required of string -> unit ]

type 'a opt = { name : 'a; arg : arg }

exception Unknown_option of string
exception Missing_argument of char

let () =
  Printexc.register_printer (function
    | Unknown_option s -> Some (Printf.sprintf "Unknown getopt option: %s" s)
    | Missing_argument c ->
        Some (Printf.sprintf "Missing argument for getopt option: %c" c)
    | _ -> None)

let opterr = getopterr ()
let optopt = getoptopt ()
let optind = getoptind ()
let optreset = getoptreset ()

let optarg () =
  let p = getoptarg () in
  string_from_ptr p ~length:(strlen p)

let print_error flag = opterr <-@ if flag then 1 else 0
let () = print_error false

let reset () =
  (* GNU *)
  if is_null optreset then optind <-@ 0
  else begin
    (* Others *)
    optreset <-@ 1;
    optind <-@ 1
  end

let remaining_argv _argv =
  let argc = CArray.length _argv in
  let optind = min !@optind argc in
  let argv = Array.of_list (CArray.to_list _argv) in
  Array.sub argv optind (argc - optind)

let apply_opt c = function
  | `None callback -> callback ()
  | `Optional callback ->
      if c = ':' then callback None else callback (Some (optarg ()))
  | `Required callback -> callback (optarg ())

let unknown_option _argv =
  let _optopt = !@optopt in
  let unknown =
    if _optopt <> Char.chr 0 then Printf.sprintf "-%c" _optopt
    else List.nth (CArray.to_list _argv) (!@optind - 1)
  in
  raise (Unknown_option unknown)

let check_result _argv c opts select =
  if c = '?' then unknown_option _argv;
  let _optopt = if c = ':' then !@optopt else c in
  let opt = List.find (select _optopt) opts in
  if c = ':' then begin
    match opt.arg with
      | `None _ -> assert false
      | `Optional _ -> ()
      | `Required _ -> raise (Missing_argument !@optopt)
  end;
  opt

let string_of_short_opt { name; arg } =
  let arg = match arg with `None _ -> "" | _ -> ":" in
  Printf.sprintf "%c%s" name arg

let getopt argv opts =
  let _argc = Array.length argv in
  let _argv = CArray.of_list string (Array.to_list argv) in
  let _short_opts = String.concat "" (List.map string_of_short_opt opts) in
  let _short_opts = ":" ^ _short_opts in
  let rec f () =
    let ret = getopt _argc (CArray.start _argv) _short_opts in
    if ret = -1 then remaining_argv _argv
    else begin
      let c = Char.chr ret in
      let { arg; _ } =
        check_result _argv c opts (fun c { name; _ } -> name = c)
      in
      apply_opt c arg;
      f ()
    end
  in
  f ()

let string_of_long_opt { name; arg } =
  let arg = match arg with `None _ -> "" | _ -> ":" in
  Printf.sprintf "%c%s" (snd name) arg

let long_opt_of_opt { name; arg } =
  let long_name, short_name = name in
  let _opt = make Option.t in
  setf _opt Option.name long_name;
  let has_arg = match arg with `None _ -> 0 | _ -> 1 in
  setf _opt Option.has_arg has_arg;
  setf _opt Option.flag (from_voidp int null);
  setf _opt Option._val (Char.code short_name);
  _opt

let getopt_long_generic fn argv opts =
  let _argc = Array.length argv in
  let _argv = CArray.of_list string (Array.to_list argv) in
  let _short_opts = String.concat "" (List.map string_of_long_opt opts) in
  let _short_opts = ":" ^ _short_opts in
  let _long_opts = List.map long_opt_of_opt opts in
  let _long_opts = CArray.of_list Option.t _long_opts in
  let index = allocate int 0 in
  let rec f () =
    let ret =
      Errno_unix.with_unix_exn (fun () ->
          Errno_unix.raise_on_errno (fun () ->
              fn _argc (CArray.start _argv) _short_opts
                (CArray.start _long_opts) index))
    in
    if ret = -1 then remaining_argv _argv
    else begin
      let c = Char.chr ret in
      let { arg; _ } =
        check_result _argv c opts (fun c { name; _ } -> snd name = c)
      in
      apply_opt c arg;
      f ()
    end
  in
  f ()

let has_getopt_long = has_getopt_long ()
let has_getopt_long_only = has_getopt_long_only ()

let getopt_long x y z t u =
  let ret = getopt_long x y z t u in
  if has_getopt_long then Some ret else None

let getopt_long_only x y z t u =
  let ret = getopt_long_only x y z t u in
  if has_getopt_long_only then Some ret else None

let getopt_long = getopt_long_generic getopt_long
let getopt_long_only = getopt_long_generic getopt_long_only
