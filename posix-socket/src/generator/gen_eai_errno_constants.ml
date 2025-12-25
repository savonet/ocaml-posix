(* Generator for the errno polymorphic variant type *)

let generate_constant_definition () =
  let names =
    List.map
      (fun (def : Eai_errno_defaults.eai_errno_def) -> def.name)
      Eai_errno_defaults.eai_errno_defs
  in

  let lines = ["module Def (S : Cstubs.Types.TYPE) = struct"] in

  let let_lines =
    List.map
      (fun name ->
        Printf.sprintf "let eai_%s = S.constant \"EAI_%s\" S.int\n"
          (String.lowercase_ascii name)
          name)
      names
  in

  lines @ let_lines @ ["end"]

let () =
  let type_def = generate_constant_definition () in
  List.iter print_endline type_def
