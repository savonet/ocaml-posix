(* Generator for errno conversion functions *)

let generate_header () =
  [
    "(* Generated errno conversion functions *)";
    "module Constants = Posix_errno_constants.Def \
     (Posix_errno_generated_constants)";
    "";
  ]

let generate_of_int_function () =
  let variants =
    List.map
      (fun (def : Errno_defaults.errno_def) -> def.name)
      Errno_defaults.errno_defs
  in
  let aliases = Errno_defaults.errno_aliases in

  let lines = ["(** Convert errno code to variant *)"; "let of_int n ="] in

  (* First errno without 'else' *)
  let first_name = List.hd variants in
  let const_name =
    String.lowercase_ascii
      (String.sub first_name 1 (String.length first_name - 1))
  in
  let first_line =
    Printf.sprintf "  if n = Constants.e_%s then `%s" const_name first_name
  in

  (* Rest of the errnos *)
  let rest_variants = List.tl variants in
  let condition_lines =
    List.map
      (fun name ->
        let const_name =
          String.lowercase_ascii (String.sub name 1 (String.length name - 1))
        in
        Printf.sprintf "  else if n = Constants.e_%s then `%s" const_name name)
      rest_variants
  in

  (* Add aliases *)
  let alias_lines =
    List.map
      (fun (name, _) ->
        let const_name =
          String.lowercase_ascii (String.sub name 1 (String.length name - 1))
        in
        Printf.sprintf "  else if n = Constants.e_%s then `%s" const_name name)
      aliases
  in

  lines @ [first_line] @ condition_lines @ alias_lines @ ["  else `EUNKNOWN n"]

let generate_to_int_function () =
  let variants =
    List.map
      (fun (def : Errno_defaults.errno_def) -> def.name)
      Errno_defaults.errno_defs
  in
  let aliases = List.map fst Errno_defaults.errno_aliases in

  let lines =
    [""; "(** Convert variant to errno code *)"; "let to_int = function"]
  in

  let case_lines =
    List.map
      (fun name ->
        let const_name =
          String.lowercase_ascii (String.sub name 1 (String.length name - 1))
        in
        Printf.sprintf "  | `%s -> Constants.e_%s" name const_name)
      variants
  in

  let alias_lines =
    List.map
      (fun name ->
        let const_name =
          String.lowercase_ascii (String.sub name 1 (String.length name - 1))
        in
        Printf.sprintf "  | `%s -> Constants.e_%s" name const_name)
      aliases
  in

  lines @ case_lines @ alias_lines @ ["  | `EUNKNOWN n -> n"]

let () =
  let header = generate_header () in
  let of_int = generate_of_int_function () in
  let to_int = generate_to_int_function () in
  let output = header @ of_int @ to_int in
  List.iter print_endline output
