open Posix_signal

let () =
  let sigset = sigemptyset () in
  sigaddset sigset `Sigint;
  ignore (sigprocmask `Sig_setmask (Some sigset));
  let old_mask = sigprocmask `Sig_setmask None in
  assert (sigismember old_mask `Sigint)
