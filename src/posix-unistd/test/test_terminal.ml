open OUnit2
open Posix_unistd
open Test_helpers

let test_isatty _ =
  test_success "isatty" "isatty" "Check if fd is a terminal" (fun () ->
      (* stdin/stdout/stderr might or might not be a tty depending on how tests run *)
      let _ = isatty Unix.stdin in
      let _ = isatty Unix.stdout in
      let _ = isatty Unix.stderr in

      (* A regular file is definitely not a tty *)
      with_temp_file (fun tmp ->
          let fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
          assert_bool "Regular file should not be a tty" (not (isatty fd));
          Unix.close fd))

let test_ttyname _ =
  (* Skip if stdin is not a tty *)
  if not (isatty Unix.stdin) then
    skip_test "ttyname" "ttyname" "Get terminal name" "stdin is not a tty"
  else (
    try
      test_success "ttyname" "ttyname" "Get terminal name" (fun () ->
          let name = ttyname Unix.stdin in
          assert_bool "tty name should not be empty" (String.length name > 0))
    with _ ->
      skip_test "ttyname" "ttyname" "Get terminal name" "ttyname not available")

let test_ttyname_r _ =
  (* Skip if stdin is not a tty *)
  if not (isatty Unix.stdin) then
    skip_test "ttyname_r" "ttyname_r" "Get terminal name (reentrant)"
      "stdin is not a tty"
  else (
    try
      test_success "ttyname_r" "ttyname_r" "Get terminal name (reentrant)"
        (fun () ->
          let name = ttyname_r Unix.stdin in
          assert_bool "tty name should not be empty" (String.length name > 0))
    with _ ->
      skip_test "ttyname_r" "ttyname_r" "Get terminal name (reentrant)"
        "ttyname_r not available")

let test_ctermid _ =
  try
    test_success "ctermid" "ctermid" "Get controlling terminal ID" (fun () ->
        let name = ctermid () in
        assert_bool "ctermid should return a name" (String.length name > 0))
  with _ ->
    skip_test "ctermid" "ctermid" "Get controlling terminal ID"
      "ctermid not available"

let suite =
  "Terminal operation tests"
  >::: [
         "test_isatty" >:: test_isatty;
         "test_ttyname" >:: test_ttyname;
         "test_ttyname_r" >:: test_ttyname_r;
         "test_ctermid" >:: test_ctermid;
       ]
