open Posix_resource

let test_getrlimit () =
  Printf.printf "Testing getrlimit...\n%!";
  let rlim = getrlimit rlimit_nofile in
  Printf.printf "  ✓ RLIMIT_NOFILE: cur=%s, max=%s\n%!"
    (Unsigned.UInt64.to_string rlim.rlim_cur)
    (Unsigned.UInt64.to_string rlim.rlim_max);
  assert (Unsigned.UInt64.(compare rlim.rlim_cur zero) > 0);
  Printf.printf "  ✓ getrlimit test passed\n%!"

let test_setrlimit () =
  Printf.printf "\nTesting setrlimit...\n%!";
  let orig = getrlimit rlimit_nofile in
  (* Try to set to same value (should always succeed) *)
  setrlimit rlimit_nofile orig;
  let new_rlim = getrlimit rlimit_nofile in
  assert (Unsigned.UInt64.equal orig.rlim_cur new_rlim.rlim_cur);
  Printf.printf "  ✓ setrlimit test passed\n%!"

let test_getrusage () =
  Printf.printf "\nTesting getrusage...\n%!";
  let ru = getrusage rusage_self in
  Printf.printf "  ✓ User time: %s\n%!" (Posix_time2.Timeval.to_string ru.ru_utime);
  Printf.printf "  ✓ System time: %s\n%!"
    (Posix_time2.Timeval.to_string ru.ru_stime);
  Printf.printf "  ✓ Max RSS: %Ld KB\n%!" ru.ru_maxrss;
  Printf.printf "  ✓ getrusage test passed\n%!"

let test_priority () =
  Printf.printf "\nTesting priority functions...\n%!";
  let prio = getpriority prio_process 0 in
  Printf.printf "  ✓ Current process priority: %d\n%!" prio;
  (* Try to set to same priority (should succeed for normal users) *)
  setpriority prio_process 0 prio;
  let new_prio = getpriority prio_process 0 in
  assert (prio = new_prio);
  Printf.printf "  ✓ priority test passed\n%!"

let test_rlim_infinity () =
  Printf.printf "\nTesting RLIM_INFINITY constant...\n%!";
  Printf.printf "  ✓ RLIM_INFINITY = %s\n%!"
    (Unsigned.UInt64.to_string rlim_infinity);
  assert (Unsigned.UInt64.(compare rlim_infinity zero) > 0);
  Printf.printf "  ✓ RLIM_INFINITY test passed\n%!"

let test_constants () =
  Printf.printf "\nTesting resource constants...\n%!";
  assert (rlimit_cpu >= 0);
  assert (rlimit_fsize >= 0);
  assert (rlimit_data >= 0);
  assert (rlimit_stack >= 0);
  assert (rlimit_core >= 0);
  assert (rlimit_nofile >= 0);
  assert (rlimit_as >= 0);
  Printf.printf "  ✓ Resource constants test passed\n%!"

let () =
  Printf.printf "=== Running posix-resource tests ===\n\n%!";
  test_constants ();
  test_getrlimit ();
  test_setrlimit ();
  test_getrusage ();
  test_priority ();
  test_rlim_infinity ();
  Printf.printf "\n=== All tests passed! ===\n%!"
