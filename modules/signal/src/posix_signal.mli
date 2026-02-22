(** Bindings to <signal.h> *)

type sigset

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

type action = [ `Sig_block | `Sig_setmask | `Sig_unblock ]

val sigemptyset : unit -> sigset
val sigaddset : sigset -> signal -> unit
val sigismember : sigset -> signal -> bool
val pthread_sigmask : action -> sigset option -> sigset
val sigprocmask : action -> sigset option -> sigset
