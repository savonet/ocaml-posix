open OUnit2
open Posix_unistd
open Test_helpers

let test_read_write _ =
  test_success "read/write" "read/write" "Read and write operations" (fun () ->
      with_temp_file (fun tmp ->
          let fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in

          (* Write *)
          let msg = Bytes.of_string "Hello, World!" in
          let written = write fd msg 0 (Bytes.length msg) in
          assert_equal (Bytes.length msg) written;

          (* Seek back *)
          ignore (lseek fd 0 Seek_set);

          (* Read *)
          let buf = Bytes.create 20 in
          let read_count = read fd buf 0 20 in
          assert_equal (Bytes.length msg) read_count;
          assert_equal "Hello, World!"
            (Bytes.sub_string buf 0 (Bytes.length msg));

          Unix.close fd))

let test_pread_pwrite _ =
  test_success "pread/pwrite" "pread/pwrite" "Positional read and write"
    (fun () ->
      with_temp_file (fun tmp ->
          let fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in

          (* Write at offset 0 *)
          let msg1 = Bytes.of_string "AAAAA" in
          ignore (pwrite fd msg1 0 5 0);

          (* Write at offset 10 *)
          let msg2 = Bytes.of_string "BBBBB" in
          ignore (pwrite fd msg2 0 5 10);

          (* Read at offset 10 *)
          let buf = Bytes.create 5 in
          let n = pread fd buf 0 5 10 in
          assert_equal 5 n;
          assert_equal "BBBBB" (Bytes.to_string buf);

          (* File offset should not have changed *)
          let pos = lseek fd 0 Seek_cur in
          assert_equal 0 pos;

          Unix.close fd))

let test_lseek _ =
  test_success "lseek" "lseek" "File seek operations" (fun () ->
      with_temp_file (fun tmp ->
          let fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in

          (* Write some data *)
          let msg = Bytes.of_string "0123456789" in
          ignore (write fd msg 0 10);

          (* Seek to beginning *)
          let pos = lseek fd 0 Seek_set in
          assert_equal 0 pos;

          (* Seek to end *)
          let pos = lseek fd 0 Seek_end in
          assert_equal 10 pos;

          (* Seek backward from current *)
          let pos = lseek fd (-5) Seek_cur in
          assert_equal 5 pos;

          Unix.close fd))

let suite =
  "I/O operation tests"
  >::: [
         "test_read_write" >:: test_read_write;
         "test_pread_pwrite" >:: test_pread_pwrite;
         "test_lseek" >:: test_lseek;
       ]
