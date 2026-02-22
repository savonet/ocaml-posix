let () =
  let path = Sys.argv.(1) in
  print_string (Unix.realpath path)
