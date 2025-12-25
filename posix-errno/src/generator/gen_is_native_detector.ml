let () =
  let c_code = Errno_defaults.generate_is_native_detector_c () in
  print_endline c_code
