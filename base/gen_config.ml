let () =
  match Sys.argv.(1) with
    | "dune" ->
        Printf.printf "(env\n";
        Printf.printf " (_\n";
        Printf.printf "  (c_flags (:standard %s))))\n"
          (String.concat " " Posix_base.c_flags)
    | "include" ->
        List.iter (fun flag -> Printf.printf "%s\n" flag) Posix_base.c_flags
    | mode ->
        failwith
          (Printf.sprintf "Unknown mode: %s (use 'dune' or 'include')" mode)
