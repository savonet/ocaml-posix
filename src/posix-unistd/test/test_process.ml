open OUnit2
open Posix_unistd
open Test_helpers

let test_getpid _ =
  test_success "getpid" "getpid" "Get process ID" (fun () ->
      let pid = getpid () in
      assert_bool "PID should be positive" (pid > 0);

      (* Verify it matches Unix.getpid *)
      assert_equal pid (Unix.getpid ()))

let test_getppid _ =
  test_success "getppid" "getppid" "Get parent process ID" (fun () ->
      let ppid = getppid () in
      assert_bool "Parent PID should be positive" (ppid > 0))

let test_getpgrp _ =
  test_success "getpgrp" "getpgrp" "Get process group" (fun () ->
      let pgrp = getpgrp () in
      assert_bool "Process group should be positive" (pgrp > 0))

let test_getuid _ =
  test_success "getuid" "getuid" "Get user ID" (fun () ->
      let uid = getuid () in
      assert_bool "UID should be non-negative" (uid >= 0);
      assert_equal uid (Unix.getuid ()))

let test_geteuid _ =
  test_success "geteuid" "geteuid" "Get effective user ID" (fun () ->
      let euid = geteuid () in
      assert_bool "Effective UID should be non-negative" (euid >= 0);
      assert_equal euid (Unix.geteuid ()))

let test_getgid _ =
  test_success "getgid" "getgid" "Get group ID" (fun () ->
      let gid = getgid () in
      assert_bool "GID should be non-negative" (gid >= 0);
      assert_equal gid (Unix.getgid ()))

let test_getegid _ =
  test_success "getegid" "getegid" "Get effective group ID" (fun () ->
      let egid = getegid () in
      assert_bool "Effective GID should be non-negative" (egid >= 0);
      assert_equal egid (Unix.getegid ()))

let test_getgroups _ =
  test_success "getgroups" "getgroups" "Get supplementary groups" (fun () ->
      let groups = getgroups () in
      assert_bool "Should have at least one group" (List.length groups > 0);
      List.iter
        (fun gid -> assert_bool "Group ID should be non-negative" (gid >= 0))
        groups)

let test_sleep _ =
  test_success "sleep" "sleep" "Sleep for seconds" (fun () ->
      (* Sleep for 0 seconds should return immediately *)
      let remaining = sleep 0 in
      assert_equal 0 remaining)

let test_alarm _ =
  test_success "alarm" "alarm" "Set alarm timer" (fun () ->
      (* Set alarm to 0 should cancel any previous alarm *)
      let _ = alarm 0 in

      (* Set and immediately cancel *)
      ignore (alarm 10);
      let remaining = alarm 0 in
      assert_bool "Should have had time remaining" (remaining > 0))

let test_usleep _ =
  test_success "usleep" "usleep" "Sleep for microseconds" (fun () ->
      (* Sleep for 1 microsecond *)
      usleep 1;
      (* Just verify it doesn't raise an exception *)
      assert_bool "usleep should complete" true)

let test_getpgid _ =
  test_success "getpgid" "getpgid" "Get process group ID" (fun () ->
      let pid = getpid () in
      let pgid = getpgid pid in
      assert_bool "Process group ID should be positive" (pgid > 0))

let test_getsid _ =
  test_success "getsid" "getsid" "Get session ID" (fun () ->
      let pid = getpid () in
      let sid = getsid pid in
      assert_bool "Session ID should be positive" (sid > 0))

let suite =
  "Process and user/group tests"
  >::: [
         "test_getpid" >:: test_getpid;
         "test_getppid" >:: test_getppid;
         "test_getpgrp" >:: test_getpgrp;
         "test_getuid" >:: test_getuid;
         "test_geteuid" >:: test_geteuid;
         "test_getgid" >:: test_getgid;
         "test_getegid" >:: test_getegid;
         "test_getgroups" >:: test_getgroups;
         "test_sleep" >:: test_sleep;
         "test_alarm" >:: test_alarm;
         "test_usleep" >:: test_usleep;
         "test_getpgid" >:: test_getpgid;
         "test_getsid" >:: test_getsid;
       ]
