open OUnit2
open Posix_unistd
open Test_helpers

let test_access _ =
  test_success "access" "access" "Check file access permissions" (fun () ->
      with_temp_file (fun tmp ->
          (* File exists *)
          assert_bool "File should exist" (access tmp [`Exists]);

          (* Readable *)
          assert_bool "File should be readable" (access tmp [`Read]);

          (* Non-existent file *)
          assert_bool "Non-existent file should return false"
            (not (access "/nonexistent/file/path" [`Exists]))))

let test_link_unlink _ =
  test_success "link/unlink" "link/unlink" "Create and remove hard link"
    (fun () ->
      with_temp_file (fun tmp ->
          let link_name = tmp ^ ".link" in

          (* Create hard link *)
          link ~target:tmp ~link_name;

          (* Verify link exists *)
          assert_bool "Link should exist" (Sys.file_exists link_name);

          (* Remove link *)
          unlink link_name;

          assert_bool "Link should not exist" (not (Sys.file_exists link_name))))

let test_symlink_readlink _ =
  test_success "symlink/readlink" "symlink/readlink"
    "Create and read symbolic link" (fun () ->
      with_temp_file (fun tmp ->
          let link_name = tmp ^ ".symlink" in

          (* Create symlink *)
          symlink ~target:tmp ~link_name;

          (* Read symlink *)
          let target = readlink link_name in
          assert_equal tmp target;

          (* Clean up *)
          unlink link_name))

let test_truncate _ =
  test_success "truncate" "truncate" "Truncate file by path" (fun () ->
      with_temp_file (fun tmp ->
          (* Write some data *)
          let fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
          let msg = Bytes.of_string "Hello, World!" in
          ignore (write fd msg 0 (Bytes.length msg));
          Unix.close fd;

          (* Truncate to 5 bytes *)
          truncate tmp 5;

          (* Verify size *)
          let size = (Unix.stat tmp).Unix.st_size in
          assert_equal 5 size))

let test_ftruncate _ =
  test_success "ftruncate" "ftruncate" "Truncate file by descriptor" (fun () ->
      with_temp_file (fun tmp ->
          let fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in

          (* Write some data *)
          let msg = Bytes.of_string "Hello, World!" in
          ignore (write fd msg 0 (Bytes.length msg));

          (* Truncate via fd *)
          ftruncate fd 7;

          Unix.close fd;

          (* Verify size *)
          let size = (Unix.stat tmp).Unix.st_size in
          assert_equal 7 size))

let test_chown _ =
  with_temp_file (fun tmp ->
      let uid = getuid () in
      let gid = getgid () in

      (* Change to same owner/group (should succeed) *)
      try
        test_success "chown" "chown" "Change file owner/group" (fun () ->
            chown tmp uid gid)
      with _ ->
        skip_test "chown" "chown" "Change file owner/group"
          "chown requires privileges or not supported")

let test_lockf _ =
  test_success "lockf" "lockf" "File locking operations" (fun () ->
      with_temp_file (fun tmp ->
          let fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in

          (* Lock the file *)
          lockf fd `Lock 0;

          (* Unlock the file *)
          lockf fd `Unlock 0;

          (* Try lock (non-blocking) *)
          lockf fd `Try_lock 0;
          lockf fd `Unlock 0;

          Unix.close fd))

let suite =
  "File operation tests"
  >::: [
         "test_access" >:: test_access;
         "test_link_unlink" >:: test_link_unlink;
         "test_symlink_readlink" >:: test_symlink_readlink;
         "test_truncate" >:: test_truncate;
         "test_ftruncate" >:: test_ftruncate;
         "test_chown" >:: test_chown;
         "test_lockf" >:: test_lockf;
       ]
