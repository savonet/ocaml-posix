open OUnit2
open Posix_unistd
open Test_helpers

(* Test error handling for file descriptor operations *)

let test_close_bad_fd _ =
  (* Closing an invalid file descriptor should raise EBADF *)
  with_temp_file (fun tmp ->
      let bad_fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      Unix.close bad_fd;
      assert_raises_errno Unix.EBADF "close" (fun () -> close bad_fd))

let test_close_twice _ =
  (* Closing the same fd twice should raise EBADF on second close *)
  with_temp_file (fun tmp ->
      let fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      close fd;
      assert_raises_errno Unix.EBADF "close" (fun () -> close fd))

let test_dup_bad_fd _ =
  (* dup on invalid fd should raise EBADF *)
  with_temp_file (fun tmp ->
      let bad_fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      Unix.close bad_fd;
      assert_raises_errno Unix.EBADF "dup" (fun () -> ignore (dup bad_fd)))

let test_dup2_bad_fd _ =
  (* dup2 with invalid source fd should raise EBADF *)
  (* Note: After closing bad_fd, opening another file may reuse the same fd number,
     so we use two separate temp files to avoid fd reuse *)
  with_temp_file (fun tmp1 ->
      with_temp_file (fun tmp2 ->
          let fd1 = Unix.openfile tmp1 [Unix.O_RDWR] 0o644 in
          let fd2 = Unix.openfile tmp2 [Unix.O_RDWR] 0o644 in
          Unix.close fd1;
          assert_raises_errno Unix.EBADF "dup2" (fun () ->
              ignore (dup2 fd1 fd2));
          Unix.close fd2))

let test_fsync_bad_fd _ =
  (* fsync on invalid fd should raise EBADF *)
  with_temp_file (fun tmp ->
      let bad_fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      Unix.close bad_fd;
      assert_raises_errno Unix.EBADF "fsync" (fun () -> fsync bad_fd))

let test_fdatasync_bad_fd _ =
  (* fdatasync on invalid fd should raise EBADF *)
  with_temp_file (fun tmp ->
      let bad_fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      Unix.close bad_fd;
      assert_raises_errno Unix.EBADF "fdatasync" (fun () -> fdatasync bad_fd))

let test_ftruncate_bad_fd _ =
  (* ftruncate on invalid fd should raise EBADF *)
  with_temp_file (fun tmp ->
      let bad_fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      Unix.close bad_fd;
      assert_raises_errno Unix.EBADF "ftruncate" (fun () -> ftruncate bad_fd 0))

let test_fchown_bad_fd _ =
  (* fchown on invalid fd should raise EBADF *)
  with_temp_file (fun tmp ->
      let bad_fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      Unix.close bad_fd;
      assert_raises_errno Unix.EBADF "fchown" (fun () -> fchown bad_fd 0 0))

let test_fchdir_bad_fd _ =
  (* fchdir on invalid fd should raise EBADF *)
  with_temp_file (fun tmp ->
      let bad_fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      Unix.close bad_fd;
      assert_raises_errno Unix.EBADF "fchdir" (fun () -> fchdir bad_fd))

let test_fpathconf_bad_fd _ =
  (* fpathconf on invalid fd returns -1 for bad fd, doesn't raise *)
  with_temp_file (fun tmp ->
      let bad_fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      Unix.close bad_fd;
      let result = fpathconf bad_fd pc_name_max in
      (* fpathconf returns -1 but doesn't check errno for invalid values *)
      assert_equal (-1) result)

let suite =
  "File descriptor error tests"
  >::: [
         "test_close_bad_fd" >:: test_close_bad_fd;
         "test_close_twice" >:: test_close_twice;
         "test_dup_bad_fd" >:: test_dup_bad_fd;
         "test_dup2_bad_fd" >:: test_dup2_bad_fd;
         "test_fsync_bad_fd" >:: test_fsync_bad_fd;
         "test_fdatasync_bad_fd" >:: test_fdatasync_bad_fd;
         "test_ftruncate_bad_fd" >:: test_ftruncate_bad_fd;
         "test_fchown_bad_fd" >:: test_fchown_bad_fd;
         "test_fchdir_bad_fd" >:: test_fchdir_bad_fd;
         "test_fpathconf_bad_fd" >:: test_fpathconf_bad_fd;
       ]
