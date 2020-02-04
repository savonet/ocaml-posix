(** Ctypes types for <signal.h> *)

val sigabrt : int
val sigalrm : int
val sigbus : int
val sigchld : int
val sigcont : int
val sigfpe : int
val sighup : int
val sigill : int
val sigint : int
val sigkill : int
val sigpipe : int
val sigquit : int
val sigsegv : int
val sigstop : int
val sigterm : int
val sigtstp : int
val sigttin : int
val sigttou : int
val sigusr1 : int
val sigusr2 : int
val sigtrap : int
val sigurg : int
val sigxcpu : int
val sigxfsz : int
val sig_block : int
val sig_setmask : int
val sig_unblock : int

module Def (S : Cstubs.Types.TYPE) : sig
  type sigset_t

  val sigset_t : sigset_t Ctypes.typ
end
