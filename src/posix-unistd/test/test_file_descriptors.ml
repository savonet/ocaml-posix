open OUnit2
open Posix_unistd
open Test_helpers

let test_pipe _ =
  test_success "pipe" "pipe" "Create and use pipe" (fun () ->
      let read_fd, write_fd = pipe () in
      (* Write to pipe *)
      let msg = Bytes.of_string "Hello, pipe!" in
      let written = write write_fd msg 0 (Bytes.length msg) in
      assert_equal (Bytes.length msg) written;

      (* Read from pipe *)
      let buf = Bytes.create 20 in
      let read_count = read read_fd buf 0 20 in
      assert_equal (Bytes.length msg) read_count;
      assert_equal "Hello, pipe!" (Bytes.sub_string buf 0 (Bytes.length msg));

      (* Close descriptors *)
      close read_fd;
      close write_fd)

let test_dup _ =
  test_success "dup" "dup" "Duplicate file descriptor" (fun () ->
      with_temp_file (fun tmp ->
          let fd = Unix.openfile tmp [Unix.O_RDWR; Unix.O_CREAT] 0o644 in

          (* Test dup *)
          let fd2 = dup fd in
          (* Write via original fd *)
          let msg = Bytes.of_string "test" in
          ignore (write fd msg 0 4);

          (* Read via duplicated fd *)
          ignore (lseek fd2 0 Seek_set);
          let buf = Bytes.create 4 in
          let n = read fd2 buf 0 4 in
          assert_equal 4 n;
          assert_equal "test" (Bytes.to_string buf);

          close fd2;
          Unix.close fd))

let test_dup2 _ =
  test_success "dup2" "dup2" "Duplicate fd to specific number" (fun () ->
      with_temp_file (fun tmp ->
          let fd1 = Unix.openfile tmp [Unix.O_RDWR; Unix.O_CREAT] 0o644 in
          let fd2 = Unix.openfile "/dev/null" [Unix.O_RDONLY] 0 in

          (* Test dup2 *)
          let _ = dup2 fd1 fd2 in
          (* fd2 should now point to tmp *)
          let msg = Bytes.of_string "dup2" in
          ignore (write fd2 msg 0 4);
          ignore (lseek fd2 0 Seek_set);
          let buf = Bytes.create 4 in
          let n = read fd2 buf 0 4 in
          assert_equal 4 n;
          assert_equal "dup2" (Bytes.to_string buf);

          Unix.close fd1;
          Unix.close fd2))

let suite =
  "File descriptor tests"
  >::: [
         "test_pipe" >:: test_pipe;
         "test_dup" >:: test_dup;
         "test_dup2" >:: test_dup2;
       ]
