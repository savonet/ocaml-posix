open OUnit2
open Posix_unistd
open Test_helpers

let test_chdir_getcwd _ =
  test_success "chdir/getcwd" "chdir/getcwd" "Change and get current directory"
    (fun () ->
      let original_dir = Sys.getcwd () in
      with_temp_dir (fun tmp ->
          (* Change to temp directory *)
          chdir tmp;

          (* Get current directory *)
          let cwd = getcwd () in
          (* Normalize paths for comparison *)
          let tmp_real = Unix.realpath tmp in
          let cwd_real = Unix.realpath cwd in
          assert_equal tmp_real cwd_real;

          (* Restore original directory *)
          Unix.chdir original_dir))

let test_rmdir _ =
  test_success "rmdir" "rmdir" "Remove directory" (fun () ->
      let tmp = Filename.temp_file "posix_unistd_test" ".dir" in
      Unix.unlink tmp;
      Unix.mkdir tmp 0o755;

      (* Remove directory *)
      rmdir tmp;
      assert_bool "Directory should not exist" (not (Sys.file_exists tmp)))

let suite =
  "Directory operation tests"
  >::: ["test_chdir_getcwd" >:: test_chdir_getcwd; "test_rmdir" >:: test_rmdir]
