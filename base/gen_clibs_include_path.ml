let () =
  Printf.printf "let c_flags = \"-I%s\"\n" (Filename.dirname Sys.argv.(1))
