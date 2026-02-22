(* Generator for errno conversion functions *)

let generate_header () =
  [
    "(* Generated errno conversion functions *)";
    "open Posix_socket_constants.Def (Posix_socket_generated_constants)";
    "";
  ]

let generate_of_int_function () =
  let variants =
    List.map
      (fun (def : Eai_errno_defaults.eai_errno_def) -> def.name)
      Eai_errno_defaults.eai_errno_defs
  in

  let lines =
    ["(** Convert eai_errno code to variant *)"; "let error_of_int n ="]
  in

  (* First errno without 'else' *)
  let first_name = List.hd variants in
  let const_name = String.lowercase_ascii first_name in
  let first_line =
    Printf.sprintf "  if n = eai_%s then `%s" const_name first_name
  in

  (* Rest of the errnos *)
  let rest_variants = List.tl variants in
  let condition_lines =
    List.map
      (fun name ->
        let const_name = String.lowercase_ascii name in
        Printf.sprintf "  else if n = eai_%s then `%s" const_name name)
      rest_variants
  in

  lines @ [first_line] @ condition_lines @ ["  else `UNKNOWN n"]

let generate_to_int_function () =
  let variants =
    List.map
      (fun (def : Eai_errno_defaults.eai_errno_def) -> def.name)
      Eai_errno_defaults.eai_errno_defs
  in

  let lines =
    [""; "(** Convert variant to errno code *)"; "let int_of_error = function"]
  in

  let case_lines =
    List.map
      (fun name ->
        let const_name = String.lowercase_ascii name in
        Printf.sprintf "  | `%s -> eai_%s" name const_name)
      variants
  in

  lines @ case_lines @ ["  | `UNKNOWN n -> n"]

let () =
  let header = generate_header () in
  let of_int = generate_of_int_function () in
  let to_int = generate_to_int_function () in
  let output = header @ of_int @ to_int in
  List.iter print_endline output
