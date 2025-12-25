(* Error handling tests for posix-signal *)
open Posix_signal

(* Test that signal operations work correctly *)
let test_sigemptyset_success () =
  Printf.printf "Testing sigemptyset (success case)...\n%!";
  let _sigset = sigemptyset () in
  Printf.printf "  ✓ sigemptyset succeeded\n%!"

let test_sigaddset_success () =
  Printf.printf "Testing sigaddset (success case)...\n%!";
  let sigset = sigemptyset () in
  sigaddset sigset `Sigint;
  sigaddset sigset `Sigterm;
  Printf.printf "  ✓ sigaddset succeeded for valid signals\n%!"

let test_sigismember_success () =
  Printf.printf "Testing sigismember (success case)...\n%!";
  let sigset = sigemptyset () in
  sigaddset sigset `Sigint;
  let is_member = sigismember sigset `Sigint in
  assert is_member;
  let not_member = sigismember sigset `Sigterm in
  assert (not not_member);
  Printf.printf "  ✓ sigismember correctly identifies members\n%!"

let test_pthread_sigmask_success () =
  Printf.printf "Testing pthread_sigmask (success case)...\n%!";
  let sigset = sigemptyset () in
  sigaddset sigset `Sigint;
  let old = pthread_sigmask `Sig_block (Some sigset) in
  ignore old;
  let _ = pthread_sigmask `Sig_unblock (Some sigset) in
  Printf.printf "  ✓ pthread_sigmask block/unblock succeeded\n%!"

let test_sigprocmask_success () =
  Printf.printf "Testing sigprocmask (success case)...\n%!";
  let sigset = sigemptyset () in
  sigaddset sigset `Sigusr1;
  let old = sigprocmask `Sig_block (Some sigset) in
  ignore old;
  let _ = sigprocmask `Sig_unblock (Some sigset) in
  Printf.printf "  ✓ sigprocmask block/unblock succeeded\n%!"

let test_sigprocmask_query () =
  Printf.printf "Testing sigprocmask query (None argument)...\n%!";
  let current_mask = sigprocmask `Sig_setmask None in
  ignore current_mask;
  Printf.printf "  ✓ sigprocmask query succeeded\n%!"

(* Test combining multiple signals *)
let test_multiple_signals () =
  Printf.printf "Testing multiple signal operations...\n%!";
  let sigset = sigemptyset () in
  List.iter
    (fun sig_ -> sigaddset sigset sig_)
    [`Sigint; `Sigterm; `Sigusr1; `Sigusr2; `Sigchld];
  List.iter
    (fun sig_ -> assert (sigismember sigset sig_))
    [`Sigint; `Sigterm; `Sigusr1; `Sigusr2; `Sigchld];
  assert (not (sigismember sigset `Sigpipe));
  Printf.printf "  ✓ Multiple signal operations succeeded\n%!"

let () =
  Printf.printf "\n=== POSIX Signal Error Handling Tests ===\n\n%!";
  test_sigemptyset_success ();
  test_sigaddset_success ();
  test_sigismember_success ();
  test_pthread_sigmask_success ();
  test_sigprocmask_success ();
  test_sigprocmask_query ();
  test_multiple_signals ();
  Printf.printf "\n✓ All signal tests passed!\n%!"
