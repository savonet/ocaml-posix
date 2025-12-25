(* Generate get_value function for tests using errno_defs *)
let generate_get_value () =
  (* Generate cases from errno_defs (not errno_defaults) to get all errno names *)
  let cases =
    List.map
      (fun (def : Eai_errno_defaults.eai_errno_def) ->
        Printf.sprintf "  | \"%s\" -> `%s" def.name def.name)
      Eai_errno_defaults.eai_errno_defs
  in
  Printf.sprintf
    {|(* Auto-generated function - do not edit manually *)
(* Generated from errno_defaults.mli using gen_get_value *)

(* Function to get system errno value from errno name *)
let get_value = function
%s
  | _ -> failwith "Unknown errno"
|}
    (String.concat "\n" cases)

let () = print_endline (generate_get_value ())
