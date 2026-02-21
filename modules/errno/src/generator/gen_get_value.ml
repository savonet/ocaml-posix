(* Generate get_value function for tests using errno_defs *)
let generate_get_value () =
  (* Generate cases from errno_defs (not errno_defaults) to get all errno names *)
  let regular_cases =
    List.map
      (fun (def : Errno_defaults.errno_def) ->
        Printf.sprintf "  | \"%s\" -> `%s" def.name def.name)
      Errno_defaults.errno_defs
  in
  let alias_cases =
    List.map
      (fun (alias_name, _target) ->
        Printf.sprintf "  | \"%s\" -> `%s" alias_name alias_name)
      Errno_defaults.errno_aliases
  in
  let all_cases = regular_cases @ alias_cases in
  Printf.sprintf
    {|(* Auto-generated function - do not edit manually *)
(* Generated from errno_defaults.mli using gen_get_value *)

(* Function to get system errno value from errno name *)
let get_value = function
%s
  | _ -> failwith "Unknown errno"
|}
    (String.concat "\n" all_cases)

let () = print_endline (generate_get_value ())
