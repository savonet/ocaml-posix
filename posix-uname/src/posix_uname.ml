open Ctypes
include Posix_uname_stubs.Def (Posix_uname_generated_stubs)

type utsname = {
  sysname : string;
  nodename : string;
  release : string;
  version : string;
  machine : string;
}

let from_utsname p =
  let get f = getf p f in
  let read f =
    let p = CArray.start (get f) in
    string_from_ptr ~length:(strlen p) p
  in
  {
    sysname = read Types.Utsname.sysname;
    nodename = read Types.Utsname.nodename;
    release = read Types.Utsname.release;
    version = read Types.Utsname.version;
    machine = read Types.Utsname.machine;
  }

let uname () =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          let p = make Types.Utsname.t in
          match uname (addr p) with
            | x when x < 0 -> None
            | _ -> Some (from_utsname p)))
