let () =
  Printf.printf "let c_flags = %S\n" ("-I" ^ Filename.dirname Sys.argv.(1))
