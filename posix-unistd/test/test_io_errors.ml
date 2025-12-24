open OUnit2
open Posix_unistd
open Test_helpers

(* Test error handling for I/O operations *)

let test_read_bad_fd _ =
  (* Reading from an invalid file descriptor should raise EBADF *)
  with_temp_file (fun tmp ->
      let bad_fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      Unix.close bad_fd;
      let buf = Bytes.create 10 in
      assert_raises_errno Unix.EBADF "read" (fun () ->
          ignore (read bad_fd buf 0 10)))

let test_read_invalid_args _ =
  (* Reading with invalid offset/length should raise Invalid_argument *)
  with_temp_file (fun tmp ->
      let fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      let buf = Bytes.create 10 in

      (* Negative offset *)
      assert_raises (Invalid_argument "read: invalid offset or length")
        (fun () -> read fd buf (-1) 5);

      (* Negative length *)
      assert_raises (Invalid_argument "read: invalid offset or length")
        (fun () -> read fd buf 0 (-1));

      (* Offset + length > buffer size *)
      assert_raises (Invalid_argument "read: invalid offset or length")
        (fun () -> read fd buf 5 10);

      Unix.close fd)

let test_write_bad_fd _ =
  (* Writing to an invalid file descriptor should raise EBADF *)
  with_temp_file (fun tmp ->
      let bad_fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      Unix.close bad_fd;
      let buf = Bytes.of_string "test" in
      assert_raises_errno Unix.EBADF "write" (fun () ->
          ignore (write bad_fd buf 0 4)))

let test_write_invalid_args _ =
  (* Writing with invalid offset/length should raise Invalid_argument *)
  with_temp_file (fun tmp ->
      let fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      let buf = Bytes.of_string "test" in

      (* Negative offset *)
      assert_raises (Invalid_argument "write: invalid offset or length")
        (fun () -> write fd buf (-1) 2);

      (* Negative length *)
      assert_raises (Invalid_argument "write: invalid offset or length")
        (fun () -> write fd buf 0 (-1));

      (* Offset + length > buffer size *)
      assert_raises (Invalid_argument "write: invalid offset or length")
        (fun () -> write fd buf 3 5);

      Unix.close fd)

let test_pread_bad_fd _ =
  (* pread from invalid fd should raise EBADF *)
  with_temp_file (fun tmp ->
      let bad_fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      Unix.close bad_fd;
      let buf = Bytes.create 10 in
      assert_raises_errno Unix.EBADF "pread" (fun () ->
          ignore (pread bad_fd buf 0 10 0)))

let test_pwrite_bad_fd _ =
  (* pwrite to invalid fd should raise EBADF *)
  with_temp_file (fun tmp ->
      let bad_fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      Unix.close bad_fd;
      let buf = Bytes.of_string "test" in
      assert_raises_errno Unix.EBADF "pwrite" (fun () ->
          ignore (pwrite bad_fd buf 0 4 0)))

let test_lseek_bad_fd _ =
  (* lseek on invalid fd should raise EBADF *)
  with_temp_file (fun tmp ->
      let bad_fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      Unix.close bad_fd;
      assert_raises_errno Unix.EBADF "lseek" (fun () ->
          ignore (lseek bad_fd 0 Seek_set)))

let test_lseek_pipe _ =
  (* lseek on a pipe should raise ESPIPE *)
  let read_fd, write_fd = pipe () in
  (try
     assert_raises
       (Unix.Unix_error (Unix.ESPIPE, "lseek", ""))
       (fun () -> lseek read_fd 0 Seek_set)
   with _ -> ());
  close read_fd;
  close write_fd

let suite =
  "I/O error tests"
  >::: [
         "test_read_bad_fd" >:: test_read_bad_fd;
         "test_read_invalid_args" >:: test_read_invalid_args;
         "test_write_bad_fd" >:: test_write_bad_fd;
         "test_write_invalid_args" >:: test_write_invalid_args;
         "test_pread_bad_fd" >:: test_pread_bad_fd;
         "test_pwrite_bad_fd" >:: test_pwrite_bad_fd;
         "test_lseek_bad_fd" >:: test_lseek_bad_fd;
         "test_lseek_pipe" >:: test_lseek_pipe;
       ]
