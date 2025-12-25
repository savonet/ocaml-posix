open Posix_errno

(* get_system_value is now generated from errno_defaults.mli in Test_get_system_value module *)

let get_alias_value _name target_name =
  try Test_get_system_value.get_system_value target_name
  with _ ->
    Printf.printf "    (alias target %s not found)\n" target_name;
    -1

let () =
  Printf.printf "=== POSIX Errno Default Values Test ===\n\n";

  (* Print system information *)
  Printf.printf "Platform: system=%s\n\n" Errno_defaults.System_detect.system;

  Printf.printf "Comparing default errno values with system values...\n\n";

  (* Compare regular errno values *)
  Printf.printf "Regular errno constants:\n";
  Printf.printf "%-20s | %-10s | %-10s | %-10s | %s\n" "Name" "Default" "System"
    "Native" "Status";
  Printf.printf "%s\n" (String.make 77 '-');

  let matching = ref 0 in
  let different = ref 0 in
  let different_list = ref [] in

  List.iter
    (fun (name, default_value) ->
      let system_value = Test_get_system_value.get_system_value name in
      let is_native_val = is_native system_value in
      let native_str = if is_native_val then "YES" else "NO" in
      let status, mark =
        if system_value = default_value then (
          incr matching;
          ("MATCH", "  "))
        else (
          incr different;
          different_list :=
            (name, default_value, system_value) :: !different_list;
          ("DIFFERENT", "**"))
      in
      Printf.printf "%s%-20s | %-10d | %-10d | %-10s | %s\n" mark name
        default_value system_value native_str status)
    Errno_defaults.errno_defaults;

  (* Handle aliases *)
  Printf.printf "\nErrno aliases:\n";
  Printf.printf "%-20s | %-15s | %-10s | %-10s\n" "Alias" "Target" "Value" "Native";
  Printf.printf "%s\n" (String.make 62 '-');

  List.iter
    (fun (alias_name, target_name) ->
      let value = get_alias_value alias_name target_name in
      if value >= 0 then (
        let is_native_val = is_native value in
        let native_str = if is_native_val then "YES" else "NO" in
        Printf.printf "  %-20s | %-15s | %-10d | %-10s\n" alias_name target_name value native_str))
    Errno_defaults.errno_aliases;

  (* Summary *)
  Printf.printf "\n=== Summary ===\n";
  Printf.printf "Total errno constants tested: %d\n"
    (List.length Errno_defaults.errno_defaults);
  Printf.printf "Values matching defaults: %d\n" !matching;
  Printf.printf "Values different from defaults: %d\n" !different;

  if !different > 0 then (
    Printf.printf "\nValues that differ from defaults:\n";
    List.iter
      (fun (name, default_val, system_val) ->
        Printf.printf "  %-20s: default=%d, system=%d (diff=%d)\n" name
          default_val system_val (system_val - default_val))
      (List.rev !different_list));

  Printf.printf
    "\nNote: The 'Native' column shows whether the errno is natively\n";
  Printf.printf
    "defined by the system (YES) or using a placeholder fallback (NO).\n";
  Printf.printf "\nValues that match the defaults may either:\n";
  Printf.printf "  1. Be natively defined by the system with that value, OR\n";
  Printf.printf
    "  2. Not be defined by the system and use the fallback default value\n";
  Printf.printf
    "\nValues that differ from defaults are definitely defined by the system.\n";
  Printf.printf
    "Use the is_native() function to distinguish between cases 1 and 2.\n";

  Printf.printf
    "\nTest completed successfully (informational only, no failures)\n"
