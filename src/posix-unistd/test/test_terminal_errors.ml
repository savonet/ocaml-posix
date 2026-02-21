open OUnit2
open Posix_unistd
open Test_helpers

(* Test error handling for terminal operations *)

let test_ttyname_not_tty _ =
  (* ttyname on non-tty fd should raise ENOTTY *)
  with_temp_file (fun tmp ->
      let fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      assert_raises_verbose
        (Unix.Unix_error (Unix.ENOTTY, "ttyname", ""))
        "ttyname on non-tty"
        (fun () -> ignore (ttyname fd));
      Unix.close fd)

let test_ttyname_bad_fd _ =
  (* ttyname on invalid fd should raise EBADF *)
  with_temp_file (fun tmp ->
      let bad_fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      Unix.close bad_fd;
      assert_raises_verbose
        (Unix.Unix_error (Unix.EBADF, "ttyname", ""))
        "ttyname on bad fd"
        (fun () -> ignore (ttyname bad_fd)))

let test_ttyname_r_not_tty _ =
  (* ttyname_r on non-tty fd should raise ENOTTY *)
  with_temp_file (fun tmp ->
      let fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      assert_raises_verbose
        (Unix.Unix_error (Unix.ENOTTY, "ttyname_r", ""))
        "ttyname_r on non-tty"
        (fun () -> ignore (ttyname_r fd));
      Unix.close fd)

let test_tcgetpgrp_not_tty _ =
  (* tcgetpgrp on non-tty fd should raise ENOTTY *)
  with_temp_file (fun tmp ->
      let fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      assert_raises_verbose
        (Unix.Unix_error (Unix.ENOTTY, "tcgetpgrp", ""))
        "tcgetpgrp on non-tty"
        (fun () -> ignore (tcgetpgrp fd));
      Unix.close fd)

let test_tcgetpgrp_bad_fd _ =
  (* tcgetpgrp on invalid fd should raise EBADF *)
  with_temp_file (fun tmp ->
      let bad_fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      Unix.close bad_fd;
      assert_raises_errno Unix.EBADF "tcgetpgrp" (fun () ->
          ignore (tcgetpgrp bad_fd)))

let test_tcsetpgrp_not_tty _ =
  (* tcsetpgrp on non-tty fd should raise ENOTTY *)
  with_temp_file (fun tmp ->
      let fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      let pgrp = getpgrp () in
      assert_raises_verbose
        (Unix.Unix_error (Unix.ENOTTY, "tcsetpgrp", ""))
        "tcsetpgrp on non-tty"
        (fun () -> tcsetpgrp fd pgrp);
      Unix.close fd)

let test_tcsetpgrp_bad_fd _ =
  (* tcsetpgrp on invalid fd should raise EBADF *)
  with_temp_file (fun tmp ->
      let bad_fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      Unix.close bad_fd;
      let pgrp = getpgrp () in
      assert_raises_errno Unix.EBADF "tcsetpgrp" (fun () ->
          tcsetpgrp bad_fd pgrp))

let suite =
  "Terminal operation error tests"
  >::: [
         "test_ttyname_not_tty" >:: test_ttyname_not_tty;
         "test_ttyname_bad_fd" >:: test_ttyname_bad_fd;
         "test_ttyname_r_not_tty" >:: test_ttyname_r_not_tty;
         "test_tcgetpgrp_not_tty" >:: test_tcgetpgrp_not_tty;
         "test_tcgetpgrp_bad_fd" >:: test_tcgetpgrp_bad_fd;
         "test_tcsetpgrp_not_tty" >:: test_tcsetpgrp_not_tty;
         "test_tcsetpgrp_bad_fd" >:: test_tcsetpgrp_bad_fd;
       ]
