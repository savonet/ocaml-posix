(* Generator for the errno polymorphic variant type *)

let generate_constant_definition () =
  let names =
    List.map
      (fun (def : Errno_defaults.errno_def) -> def.name)
      Errno_defaults.errno_defs
    @ List.map fst Errno_defaults.errno_aliases
  in

  let lines = ["module Def (S : Cstubs.Types.TYPE) = struct"] in

  (* Generate polymorphic variant constructors from errno_defs *)
  let let_lines =
    List.map
      (fun name ->
        let error_name =
          String.sub name 0 1 ^ "_" ^ String.sub name 1 (String.length name - 1)
        in
        Printf.sprintf "let %s = S.constant \"%s\" S.int\n"
          (String.lowercase_ascii error_name)
          name)
      names
  in

  (* Add unknown directly *)
  lines @ let_lines @ ["end"]

let () =
  let type_def = generate_constant_definition () in
  List.iter print_endline type_def
