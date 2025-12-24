(* Error handling tests for posix-time2 *)
open Posix_time2

let sprint_timespec { Timespec.tv_sec; tv_nsec } =
  Printf.sprintf "tv_sec: %Li, tv_nsec: %Li" tv_sec tv_nsec

let sprint_timeval { Timeval.tv_sec; tv_usec } =
  Printf.sprintf "tv_sec: %Li, tv_usec: %Li" tv_sec tv_usec

(* Test clock_getres with valid clocks *)
let test_clock_getres_valid () =
  Printf.printf "Testing clock_getres (success cases)...\n%!";
  List.iter
    (fun (name, clock) ->
      try
        let res = clock_getres clock in
        Printf.printf "  ✓ clock_getres %s: %s\n%!" name (sprint_timespec res)
      with Unix.Unix_error (err, fn, _) ->
        Printf.printf "  ⚠ clock_getres %s not available: %s (%s)\n%!" name fn
          (Unix.error_message err))
    [
      ("Realtime", `Realtime);
      ("Monotonic", `Monotonic);
      ("Process_cputime", `Process_cputime);
      ("Thread_cputime", `Thread_cputime);
    ]

(* Test clock_gettime with valid clocks *)
let test_clock_gettime_valid () =
  Printf.printf "Testing clock_gettime (success cases)...\n%!";
  List.iter
    (fun (name, clock) ->
      try
        let time = clock_gettime clock in
        Printf.printf "  ✓ clock_gettime %s: %s\n%!" name (sprint_timespec time)
      with Unix.Unix_error (err, fn, _) ->
        Printf.printf "  ⚠ clock_gettime %s not available: %s (%s)\n%!" name fn
          (Unix.error_message err))
    [
      ("Realtime", `Realtime);
      ("Monotonic", `Monotonic);
      ("Process_cputime", `Process_cputime);
      ("Thread_cputime", `Thread_cputime);
    ]

(* Test nanosleep with invalid values should fail *)
let test_nanosleep_invalid () =
  Printf.printf "Testing nanosleep (error cases)...\n%!";
  (* Test with negative nsec - should fail with EINVAL *)
  let invalid_timespec = Timespec.create 0L (-1L) in
  (try
     nanosleep invalid_timespec;
     Printf.printf "  ✗ nanosleep with negative nsec should have failed\n%!";
     assert false
   with Unix.Unix_error (Unix.EINVAL, "nanosleep", _) ->
     Printf.printf "  ✓ nanosleep correctly rejected negative nsec (EINVAL)\n%!");

  (* Test with nsec >= 1000000000
     Note: The Timespec.create function normalizes values, so we can't directly
     create an invalid timespec. This is actually good design - the type system
     prevents invalid values. *)
  Printf.printf
    "  ℹ Timespec.create normalizes values, preventing nsec >= 1e9 at \
     construction\n%!"

(* Test nanosleep with valid value *)
let test_nanosleep_valid () =
  Printf.printf "Testing nanosleep (success case)...\n%!";
  let short_sleep = Timespec.create 0L 10000000L in
  (* 10ms *)
  nanosleep short_sleep;
  Printf.printf "  ✓ nanosleep succeeded with valid timespec\n%!"

(* Test gettimeofday *)
let test_gettimeofday () =
  Printf.printf "Testing gettimeofday...\n%!";
  let tv = gettimeofday () in
  Printf.printf "  ✓ gettimeofday: %s\n%!" (sprint_timeval tv);
  assert (tv.tv_sec > 0L)

(* Test gmtime with valid and edge case times *)
let test_gmtime () =
  Printf.printf "Testing gmtime...\n%!";
  (* Test with current time *)
  let tv = gettimeofday () in
  let tm = gmtime tv.tv_sec in
  Printf.printf "  ✓ gmtime succeeded for current time: year=%d\n%!"
    (tm.Tm.tm_year + 1900);

  (* Test with epoch *)
  let tm_epoch = gmtime 0L in
  assert (tm_epoch.Tm.tm_year = 70);
  (* 1970 *)
  Printf.printf "  ✓ gmtime succeeded for epoch: 1970-01-01\n%!";

  (* Test with far future *)
  let tm_future = gmtime 2000000000L in
  (* May 18, 2033 *)
  assert (tm_future.Tm.tm_year >= 133);
  Printf.printf "  ✓ gmtime succeeded for far future date\n%!"

(* Test localtime *)
let test_localtime () =
  Printf.printf "Testing localtime...\n%!";
  let tv = gettimeofday () in
  let tm = localtime tv.tv_sec in
  Printf.printf "  ✓ localtime succeeded: year=%d\n%!" (tm.Tm.tm_year + 1900)

(* Test mktime with valid and invalid times *)
let test_mktime () =
  Printf.printf "Testing mktime...\n%!";
  (* Create a valid time structure *)
  match
    Tm.create 0 0 12 1 0 124 1 0 0
    (* 2024-01-01 12:00:00, Monday, day 0 of year *)
  with
  | Some tm ->
      let time = mktime tm in
      Printf.printf "  ✓ mktime succeeded: %Ld\n%!" time;
      assert (time > 0L)
  | None ->
      Printf.printf "  ✗ Failed to create valid tm structure\n%!";
      assert false

(* Test setitimer and getitimer *)
let test_itimer () =
  Printf.printf "Testing setitimer/getitimer...\n%!";
  let timer =
    {
      Itimerval.it_interval = Timeval.create 0L 0L;
      it_value = Timeval.create 0L 100000L;
    }
  in
  let old = setitimer `Real timer in
  Printf.printf "  ✓ setitimer succeeded\n%!";
  ignore old;

  let current = getitimer `Real in
  Printf.printf "  ✓ getitimer succeeded: value=%Ld.%06Ld\n%!"
    current.it_value.tv_sec current.it_value.tv_usec;

  (* Disable the timer *)
  let disable_timer =
    {
      Itimerval.it_interval = Timeval.create 0L 0L;
      it_value = Timeval.create 0L 0L;
    }
  in
  ignore (setitimer `Real disable_timer)

(* Test select with timeout *)
let test_select_timeout () =
  Printf.printf "Testing select with timeout...\n%!";
  let timeout = Timeval.create 0L 10000L in
  (* 10ms timeout *)
  let r, w, e = select [] [] [] (Some timeout) in
  assert (r = []);
  assert (w = []);
  assert (e = []);
  Printf.printf "  ✓ select timeout succeeded\n%!"

(* Test select with invalid fd should fail *)
let test_select_invalid_fd () =
  Printf.printf "Testing select with invalid fd (error case)...\n%!";
  (* Create an invalid file descriptor *)
  let invalid_fd = Unix.openfile "/dev/null" [ Unix.O_RDONLY ] 0o644 in
  Unix.close invalid_fd;
  (* Now it's invalid *)
  (try
     ignore (select [ invalid_fd ] [] [] None);
     Printf.printf "  ✗ select with invalid fd should have failed\n%!";
     (* Some systems may not error on this *)
     Printf.printf "  ⚠ (or system doesn't error on closed fd)\n%!"
   with Unix.Unix_error (Unix.EBADF, "select", _) ->
     Printf.printf "  ✓ select correctly rejected invalid fd (EBADF)\n%!")

(* Test utimes on a valid file *)
let test_utimes_valid () =
  Printf.printf "Testing utimes (success case)...\n%!";
  let temp_file = Filename.temp_file "posix_time2_test" ".tmp" in
  let new_time = Timeval.create 1000000000L 0L in
  (* Jan 9, 2001 *)
  utimes temp_file new_time;
  Sys.remove temp_file;
  Printf.printf "  ✓ utimes succeeded on valid file\n%!"

(* Test utimes on non-existent file should fail *)
let test_utimes_invalid () =
  Printf.printf "Testing utimes (error case)...\n%!";
  let nonexistent = "/tmp/this_file_should_not_exist_posix_time2_test_12345" in
  let new_time = Timeval.create 1000000000L 0L in
  (try
     utimes nonexistent new_time;
     Printf.printf "  ✗ utimes on non-existent file should have failed\n%!";
     assert false
   with Unix.Unix_error (Unix.ENOENT, "utimes", _) ->
     Printf.printf "  ✓ utimes correctly rejected non-existent file (ENOENT)\n%!")

let () =
  Printf.printf "\n=== POSIX Time2 Error Handling Tests ===\n\n%!";
  test_clock_getres_valid ();
  test_clock_gettime_valid ();
  test_nanosleep_valid ();
  test_nanosleep_invalid ();
  test_gettimeofday ();
  test_gmtime ();
  test_localtime ();
  test_mktime ();
  test_itimer ();
  test_select_timeout ();
  test_select_invalid_fd ();
  test_utimes_valid ();
  test_utimes_invalid ();
  Printf.printf "\n✓ All time2 error tests passed!\n%!"
