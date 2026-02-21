open OUnit2
open Posix_unistd
open Test_helpers

let test_fsync _ =
  test_success "fsync" "fsync" "Sync file to disk" (fun () ->
      with_temp_file (fun tmp ->
          let fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in

          (* Write data *)
          let msg = Bytes.of_string "sync test" in
          ignore (write fd msg 0 (Bytes.length msg));

          (* Sync *)
          fsync fd;

          Unix.close fd))

let test_fdatasync _ =
  test_success "fdatasync" "fdatasync" "Sync file data to disk" (fun () ->
      with_temp_file (fun tmp ->
          let fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in

          (* Write data *)
          let msg = Bytes.of_string "datasync test" in
          ignore (write fd msg 0 (Bytes.length msg));

          (* Sync data *)
          fdatasync fd;

          Unix.close fd))

let test_sync_all _ =
  test_success "sync" "sync" "Sync all filesystems" (fun () ->
      (* Just ensure it doesn't crash *)
      sync ())

let suite =
  "Synchronization tests"
  >::: [
         "test_fsync" >:: test_fsync;
         "test_fdatasync" >:: test_fdatasync;
         "test_sync_all" >:: test_sync_all;
       ]
