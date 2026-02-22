(* Generator for the errno polymorphic variant type *)

let generate_type_definition () =
  let variants =
    List.map
      (fun (def : Eai_errno_defaults.eai_errno_def) -> def.name)
      Eai_errno_defaults.eai_errno_defs
  in

  let lines =
    [
      "(** Comprehensive eai_errno type covering Linux, BSD, macOS, and \
       Windows values *)";
      "type error = [";
    ]
  in

  (* Generate polymorphic variant constructors from errno_defs *)
  let variant_lines =
    List.mapi
      (fun i name ->
        let sep = if i = 0 then "  " else "| " in
        "  " ^ sep ^ "`" ^ name)
      variants
  in

  (* Add unknown directly *)
  lines @ variant_lines @ ["  (* Unknown *)"; "  | `UNKNOWN of int"; "]"]

let () =
  let type_def = generate_type_definition () in
  List.iter print_endline type_def
