open Posix_stat

let test_stat () =
  Printf.printf "Testing stat on current directory...\n%!";
  let st = stat "." in
  assert (s_isdir st.st_mode);
  Printf.printf "  ✓ Current directory inode: %s\n%!"
    (Posix_types.Ino.to_string st.st_ino);
  Printf.printf "  ✓ Current directory is detected as directory\n%!"

let test_file_type_tests () =
  Printf.printf "\nTesting file type detection functions...\n%!";
  let st = stat "." in
  assert (s_isdir st.st_mode);
  assert (not (s_isreg st.st_mode));
  assert (not (s_islnk st.st_mode));
  Printf.printf "  ✓ File type tests work correctly\n%!"

let test_constants () =
  Printf.printf "\nTesting permission constants...\n%!";
  let mode = Posix_types.Mode.(logor s_irusr (logor s_iwusr s_irgrp)) in
  assert (Posix_types.Mode.(compare mode zero) > 0);
  Printf.printf "  ✓ Permission constants work\n%!"

let test_mkdir () =
  Printf.printf "\nTesting mkdir and rmdir...\n%!";
  let temp_dir = "test_dir_" ^ string_of_int (Unix.getpid ()) in
  let mode = Posix_types.Mode.(logor s_irwxu (logor s_irgrp s_ixgrp)) in
  mkdir temp_dir mode;
  let st = stat temp_dir in
  assert (s_isdir st.st_mode);
  Unix.rmdir temp_dir;
  Printf.printf "  ✓ mkdir/rmdir test passed\n%!"

let test_chmod () =
  Printf.printf "\nTesting chmod...\n%!";
  let temp_file = "test_file_" ^ string_of_int (Unix.getpid ()) in
  let fd = Unix.openfile temp_file [Unix.O_CREAT; Unix.O_WRONLY] 0o644 in
  Unix.close fd;
  let mode_rw = Posix_types.Mode.(logor s_irusr s_iwusr) in
  chmod temp_file mode_rw;
  let st = stat temp_file in
  assert (s_isreg st.st_mode);
  Unix.unlink temp_file;
  Printf.printf "  ✓ chmod test passed\n%!"

let test_fstat () =
  Printf.printf "\nTesting fstat...\n%!";
  let fd = Unix.openfile "." [Unix.O_RDONLY] 0 in
  let st = fstat fd in
  assert (s_isdir st.st_mode);
  Unix.close fd;
  Printf.printf "  ✓ fstat test passed\n%!"

let test_lstat () =
  Printf.printf "\nTesting lstat...\n%!";
  let st = lstat "." in
  assert (s_isdir st.st_mode);
  Printf.printf "  ✓ lstat test passed\n%!"

let test_umask () =
  Printf.printf "\nTesting umask...\n%!";
  let old_mask = umask Posix_types.Mode.zero in
  let _ = umask old_mask in
  Printf.printf "  ✓ umask test passed\n%!"

let test_at_functions () =
  Printf.printf "\nTesting *at functions...\n%!";
  let temp_dir = "test_at_dir_" ^ string_of_int (Unix.getpid ()) in
  let mode = Posix_types.Mode.(logor s_irwxu (logor s_irgrp s_ixgrp)) in
  (* Test fstatat with AT_FDCWD *)
  mkdirat temp_dir mode;
  let st = fstatat temp_dir in
  assert (s_isdir st.st_mode);
  Unix.rmdir temp_dir;
  Printf.printf "  ✓ *at functions test passed\n%!"

let () =
  Printf.printf "=== Running posix-stat tests ===\n\n%!";
  test_stat ();
  test_file_type_tests ();
  test_constants ();
  test_mkdir ();
  test_chmod ();
  test_fstat ();
  test_lstat ();
  test_umask ();
  test_at_functions ();
  Printf.printf "\n=== All tests passed! ===\n%!"
