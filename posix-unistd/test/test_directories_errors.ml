open OUnit2
open Posix_unistd
open Test_helpers

(* Test error handling for directory operations *)

let test_chdir_nonexistent _ =
  (* Changing to nonexistent directory should raise ENOENT *)
  assert_raises_verbose
    (Unix.Unix_error (Unix.ENOENT, "chdir", ""))
    "chdir to nonexistent"
    (fun () -> chdir "/nonexistent/directory")

let test_chdir_not_directory _ =
  (* Changing to a file (not directory) should raise ENOTDIR *)
  with_temp_file (fun tmp ->
      assert_raises_verbose
        (Unix.Unix_error (Unix.ENOTDIR, "chdir", ""))
        "chdir to file"
        (fun () -> chdir tmp))

let test_rmdir_nonexistent _ =
  (* Removing nonexistent directory should raise ENOENT *)
  assert_raises_verbose
    (Unix.Unix_error (Unix.ENOENT, "rmdir", ""))
    "rmdir nonexistent"
    (fun () -> rmdir "/nonexistent/directory")

let test_rmdir_not_directory _ =
  (* Removing a file (not directory) should raise ENOTDIR *)
  with_temp_file (fun tmp ->
      assert_raises_verbose
        (Unix.Unix_error (Unix.ENOTDIR, "rmdir", ""))
        "rmdir file"
        (fun () -> rmdir tmp))

let test_rmdir_nonempty _ =
  (* Removing non-empty directory should raise ENOTEMPTY or EEXIST *)
  with_temp_dir (fun tmpdir ->
      (* Create a file in the directory *)
      let filepath = Filename.concat tmpdir "testfile" in
      let fd = Unix.openfile filepath [Unix.O_CREAT; Unix.O_WRONLY] 0o644 in
      Unix.close fd;
      try
        rmdir tmpdir;
        assert_failure "Unexpected success - should have failed"
      with Unix.Unix_error ((Unix.ENOTEMPTY | Unix.EEXIST), "rmdir", _) ->
        Unix.unlink filepath)

let test_getcwd_after_delete _ =
  (* This test checks behavior when current directory is deleted *)
  (* getcwd should either succeed or raise ENOENT depending on system *)
  let original_dir = Sys.getcwd () in
  with_temp_dir (fun tmpdir ->
      chdir tmpdir;
      (* Delete the current directory from another path reference *)
      Unix.rmdir tmpdir;
      try
        let _ = getcwd () in
        (* Some systems allow this *)
        ()
      with Unix.Unix_error (Unix.ENOENT, "getcwd", "") ->
        (* Other systems raise ENOENT *)
        ());
  (* Restore original directory *)
  Unix.chdir original_dir

let test_pathconf_nonexistent _ =
  (* pathconf on nonexistent file returns -1 without raising *)
  let result = pathconf "/nonexistent/file" pc_name_max in
  (* pathconf returns -1 for errors but doesn't check errno *)
  assert_equal (-1) result

let suite =
  "Directory operation error tests"
  >::: [
         "test_chdir_nonexistent" >:: test_chdir_nonexistent;
         "test_chdir_not_directory" >:: test_chdir_not_directory;
         "test_rmdir_nonexistent" >:: test_rmdir_nonexistent;
         "test_rmdir_not_directory" >:: test_rmdir_not_directory;
         "test_rmdir_nonempty" >:: test_rmdir_nonempty;
         "test_getcwd_after_delete" >:: test_getcwd_after_delete;
         "test_pathconf_nonexistent" >:: test_pathconf_nonexistent;
       ]
