open OUnit2
open Posix_unistd
open Test_helpers

(* Test error handling for system info operations *)

let test_sethostname_eperm _ =
  (* sethostname as non-root should raise EPERM *)
  if getuid () = 0 then
    skip_test "sethostname as non-root" "sethostname"
      "Operation not permitted (sethostname)" "Running as root"
  else
    assert_raises_verbose
      (Unix.Unix_error (Unix.EPERM, "sethostname", ""))
      "sethostname as non-root"
      (fun () -> sethostname "testhostname")

let test_getlogin_r_small_buffer _ =
  (* getlogin_r with too small buffer should raise ERANGE *)
    try
      let _ = getlogin_r ~len:1 () in
      (* May succeed with very short login names *)
      ()
    with
    | Unix.Unix_error (Unix.ERANGE, "getlogin_r", "") ->
        (* Expected for most cases *)
        ()
    | Unix.Unix_error (Unix.ENOTTY, "getlogin_r", "") ->
        (* Expected in containerized/non-TTY environments *)
        ()

let suite =
  "System info error tests"
  >::: [
         "test_sethostname_eperm" >:: test_sethostname_eperm;
         "test_getlogin_r_small_buffer" >:: test_getlogin_r_small_buffer;
       ]
