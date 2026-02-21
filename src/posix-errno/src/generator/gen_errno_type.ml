(* Generator for the errno polymorphic variant type *)

let generate_type_definition () =
  let variants =
    List.map
      (fun (def : Errno_defaults.errno_def) -> def.name)
      Errno_defaults.errno_defs
  in
  let aliases = List.map fst Errno_defaults.errno_aliases in

  let lines =
    [
      "(** Comprehensive errno type covering Linux, BSD, macOS, and Windows \
       values *)";
      "type t = [";
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

  (* Add aliases *)
  let alias_lines = List.map (fun name -> "  | `" ^ name) aliases in

  (* Add unknown directly *)
  lines @ variant_lines @ alias_lines
  @ ["  (* Unknown *)"; "  | `EUNKNOWN of int"; "]"]

let () =
  let type_def = generate_type_definition () in
  List.iter print_endline type_def
