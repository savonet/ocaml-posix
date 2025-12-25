open Ctypes
open Posix_signal_types
include Posix_signal_stubs.Def (Posix_signal_generated_stubs)

type sigset = Types.sigset_t ptr

type signal =
  [ `Sigabrt
  | `Sigalrm
  | `Sigbus
  | `Sigchld
  | `Sigcont
  | `Sigfpe
  | `Sighup
  | `Sigill
  | `Sigint
  | `Sigkill
  | `Sigpipe
  | `Sigquit
  | `Sigsegv
  | `Sigstop
  | `Sigterm
  | `Sigtstp
  | `Sigttin
  | `Sigttou
  | `Sigusr1
  | `Sigusr2
  | `Sigtrap
  | `Sigurg
  | `Sigxcpu
  | `Sigxfsz ]

let int_of_signal = function
  | `Sigabrt -> sigabrt
  | `Sigalrm -> sigalrm
  | `Sigbus -> sigbus
  | `Sigchld -> sigchld
  | `Sigcont -> sigcont
  | `Sigfpe -> sigfpe
  | `Sighup -> sighup
  | `Sigill -> sigill
  | `Sigint -> sigint
  | `Sigkill -> sigkill
  | `Sigpipe -> sigpipe
  | `Sigquit -> sigquit
  | `Sigsegv -> sigsegv
  | `Sigstop -> sigstop
  | `Sigterm -> sigterm
  | `Sigtstp -> sigtstp
  | `Sigttin -> sigttin
  | `Sigttou -> sigttou
  | `Sigusr1 -> sigusr1
  | `Sigusr2 -> sigusr2
  | `Sigtrap -> sigtrap
  | `Sigurg -> sigurg
  | `Sigxcpu -> sigxcpu
  | `Sigxfsz -> sigxfsz

type action = [ `Sig_block | `Sig_setmask | `Sig_unblock ]

let int_of_action = function
  | `Sig_block -> sig_block
  | `Sig_setmask -> sig_setmask
  | `Sig_unblock -> sig_unblock

let sigemptyset () =
  Posix_errno.raise_on_none ~call:"sigemptyset" (fun () ->
      let p = allocate_n Types.sigset_t ~count:1 in
      match sigemptyset p with x when x < 0 -> None | _ -> Some p)

let sigaddset sigset signal =
  Posix_errno.raise_on_none ~call:"sigaddset" (fun () ->
      let signal = int_of_signal signal in
      match sigaddset sigset signal with x when x < 0 -> None | _ -> Some ())

let sigismember sigset signal =
  Posix_errno.raise_on_none ~call:"sigismember" (fun () ->
      let signal = int_of_signal signal in
      match sigismember sigset signal with
        | x when x < 0 -> None
        | 1 -> Some true
        | _ -> Some false)

let pthread_sigmask action sigset =
  Posix_errno.raise_on_none ~call:"pthread_sigmask" (fun () ->
      let action = int_of_action action in
      let sigset =
        match sigset with Some p -> p | None -> from_voidp Types.sigset_t null
      in
      let old_sigset = allocate_n Types.sigset_t ~count:1 in
      match pthread_sigmask action sigset old_sigset with
        | x when x < 0 -> None
        | _ -> Some old_sigset)

let sigprocmask action sigset =
  Posix_errno.raise_on_none ~call:"sigprocmask" (fun () ->
      let action = int_of_action action in
      let sigset =
        match sigset with Some p -> p | None -> from_voidp Types.sigset_t null
      in
      let old_sigset = allocate_n Types.sigset_t ~count:1 in
      match sigprocmask action sigset old_sigset with
        | x when x < 0 -> None
        | _ -> Some old_sigset)
