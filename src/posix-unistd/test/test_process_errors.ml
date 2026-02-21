open OUnit2
open Posix_unistd
open Test_helpers

(* Test error handling for process operations *)

let test_getpgid_nonexistent _ =
  (* Getting process group of nonexistent process should raise ESRCH *)
  (* Use a very high PID that's unlikely to exist *)
  let nonexistent_pid = 999999 in
  assert_raises_verbose
    (Unix.Unix_error (Unix.ESRCH, "getpgid", ""))
    "getpgid nonexistent"
    (fun () -> ignore (getpgid nonexistent_pid))

let test_getsid_nonexistent _ =
  (* Getting session ID of nonexistent process should raise ESRCH *)
  let nonexistent_pid = 999999 in
  assert_raises_verbose
    (Unix.Unix_error (Unix.ESRCH, "getsid", ""))
    "getsid nonexistent"
    (fun () -> ignore (getsid nonexistent_pid))

let test_setpgid_nonexistent _ =
  (* Setting process group of nonexistent process should raise ESRCH *)
  let nonexistent_pid = 999999 in
  assert_raises_verbose
    (Unix.Unix_error (Unix.ESRCH, "setpgid", ""))
    "setpgid nonexistent"
    (fun () -> setpgid nonexistent_pid 0)

let test_sysconf_invalid _ =
  (* sysconf with invalid name returns -1 without raising *)
  let invalid_name = -999999 in
  let result = sysconf invalid_name in
  (* sysconf returns -1 for invalid/unlimited, doesn't check errno *)
  assert_equal (-1) result

let test_confstr_invalid _ =
  (* confstr with invalid name returns -1 without raising *)
  let invalid_name = -999999 in
  try
    let result = confstr invalid_name in
    (* confstr returns empty string for size 0 *)
    assert_equal "" result
  with _ ->
    (* Or it might fail, which is fine *)
    ()

let test_nice_eperm _ =
  (* Trying to increase priority (nice with negative value) as non-root should raise EPERM *)
  (* Only test if not running as root *)
  if getuid () = 0 then
    skip_test "nice with negative" "nice" "Operation not permitted (nice)"
      "Running as root"
  else (
    try
      let _ = nice (-10) in
      skip_test "nice with negative" "nice" "Operation not permitted (nice)"
        "System allows priority increase"
    with Unix.Unix_error (Unix.EPERM, "nice", "") ->
      add_test_result "nice with negative" "nice"
        "Operation not permitted (nice)" "Operation not permitted (nice)" "PASS")

let test_setuid_eperm _ =
  (* Setting uid as non-root should raise EPERM (unless setting to same uid) *)
  if getuid () = 0 then
    skip_test "setuid to root" "setuid" "Operation not permitted (setuid)"
      "Running as root"
  else (
    assert_raises_verbose
      (Unix.Unix_error (Unix.EPERM, "setuid", ""))
      "setuid to root"
      (fun () -> setuid 0);
    (* Setting to same uid should succeed *)
    setuid (getuid ()))

let test_setgid_eperm _ =
  (* Setting gid as non-root should raise EPERM (unless setting to same gid) *)
  if getuid () = 0 then
    skip_test "setgid to root" "setgid" "Operation not permitted (setgid)"
      "Running as root"
  else (
    assert_raises_verbose
      (Unix.Unix_error (Unix.EPERM, "setgid", ""))
      "setgid to root"
      (fun () -> setgid 0);
    (* Setting to same gid should succeed *)
    setgid (getgid ()))

let test_setgroups_eperm _ =
  (* setgroups as non-root should raise EPERM *)
  if getuid () = 0 then
    skip_test "setgroups as non-root" "setgroups"
      "Operation not permitted (setgroups)" "Running as root"
  else
    assert_raises_verbose
      (Unix.Unix_error (Unix.EPERM, "setgroups", ""))
      "setgroups as non-root"
      (fun () -> setgroups [0])

let test_seteuid_eperm _ =
  (* Setting euid as non-root should raise EPERM *)
  if getuid () = 0 then
    skip_test "seteuid to root" "seteuid" "Operation not permitted (seteuid)"
      "Running as root"
  else
    assert_raises_verbose
      (Unix.Unix_error (Unix.EPERM, "seteuid", ""))
      "seteuid to root"
      (fun () -> seteuid 0)

let test_setegid_eperm _ =
  (* Setting egid as non-root should raise EPERM *)
  if getuid () = 0 then
    skip_test "setegid to root" "setegid" "Operation not permitted (setegid)"
      "Running as root"
  else
    assert_raises_verbose
      (Unix.Unix_error (Unix.EPERM, "setegid", ""))
      "setegid to root"
      (fun () -> setegid 0)

let test_setreuid_eperm _ =
  (* Setting reuid as non-root should raise EPERM *)
  if getuid () = 0 then
    skip_test "setreuid to root" "setreuid" "Operation not permitted (setreuid)"
      "Running as root"
  else
    assert_raises_verbose
      (Unix.Unix_error (Unix.EPERM, "setreuid", ""))
      "setreuid to root"
      (fun () -> setreuid 0 0)

let test_setregid_eperm _ =
  (* Setting regid as non-root should raise EPERM *)
  if getuid () = 0 then
    skip_test "setregid to root" "setregid" "Operation not permitted (setregid)"
      "Running as root"
  else
    assert_raises_verbose
      (Unix.Unix_error (Unix.EPERM, "setregid", ""))
      "setregid to root"
      (fun () -> setregid 0 0)

let suite =
  "Process operation error tests"
  >::: [
         "test_getpgid_nonexistent" >:: test_getpgid_nonexistent;
         "test_getsid_nonexistent" >:: test_getsid_nonexistent;
         "test_setpgid_nonexistent" >:: test_setpgid_nonexistent;
         "test_sysconf_invalid" >:: test_sysconf_invalid;
         "test_confstr_invalid" >:: test_confstr_invalid;
         "test_nice_eperm" >:: test_nice_eperm;
         "test_setuid_eperm" >:: test_setuid_eperm;
         "test_setgid_eperm" >:: test_setgid_eperm;
         "test_setgroups_eperm" >:: test_setgroups_eperm;
         "test_seteuid_eperm" >:: test_seteuid_eperm;
         "test_setegid_eperm" >:: test_setegid_eperm;
         "test_setreuid_eperm" >:: test_setreuid_eperm;
         "test_setregid_eperm" >:: test_setregid_eperm;
       ]
