(** POSIX signal handling bindings.

    This module provides OCaml bindings to POSIX signal functions defined in
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/signal.h.html}
     signal.h}.

    It includes functions for manipulating signal sets and controlling signal
    delivery to threads and processes. *)

(** {1 Signal Sets} *)

(** Abstract type representing a set of signals. *)
type sigset

(** POSIX signals. *)
type signal =
  [ `Sigabrt  (** Abnormal termination *)
  | `Sigalrm  (** Alarm clock *)
  | `Sigbus  (** Bus error *)
  | `Sigchld  (** Child process terminated *)
  | `Sigcont  (** Continue if stopped *)
  | `Sigfpe  (** Floating-point exception *)
  | `Sighup  (** Hangup *)
  | `Sigill  (** Illegal instruction *)
  | `Sigint  (** Interactive attention signal *)
  | `Sigkill  (** Kill (cannot be caught or ignored) *)
  | `Sigpipe  (** Broken pipe *)
  | `Sigquit  (** Quit *)
  | `Sigsegv  (** Segmentation fault *)
  | `Sigstop  (** Stop (cannot be caught or ignored) *)
  | `Sigterm  (** Termination request *)
  | `Sigtstp  (** Terminal stop *)
  | `Sigttin  (** Background read from terminal *)
  | `Sigttou  (** Background write to terminal *)
  | `Sigusr1  (** User-defined signal 1 *)
  | `Sigusr2  (** User-defined signal 2 *)
  | `Sigtrap  (** Trace/breakpoint trap *)
  | `Sigurg  (** Urgent data on socket *)
  | `Sigxcpu  (** CPU time limit exceeded *)
  | `Sigxfsz ]
(** File size limit exceeded *)

(** {1 Signal Mask Actions} *)

(** Actions for modifying the signal mask. *)
type action =
  [ `Sig_block  (** Add signals to the mask *)
  | `Sig_setmask  (** Set the mask to the specified signals *)
  | `Sig_unblock  (** Remove signals from the mask *) ]

(** {1 Signal Set Functions} *)

(** Create an empty signal set. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/sigemptyset.html}
     sigemptyset(3)}. *)
val sigemptyset : unit -> sigset

(** Add a signal to a signal set. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/sigaddset.html}
     sigaddset(3)}. *)
val sigaddset : sigset -> signal -> unit

(** Test whether a signal is in a signal set. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/sigismember.html}
     sigismember(3)}. *)
val sigismember : sigset -> signal -> bool

(** {1 Signal Mask Functions} *)

(** Examine and change the signal mask of the calling thread.

    See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/pthread_sigmask.html}
     pthread_sigmask(3)}.

    @param action How to modify the signal mask.
    @param set
      The signal set to use, or [None] to only retrieve the current mask.
    @return The previous signal mask. *)
val pthread_sigmask : action -> sigset option -> sigset

(** Examine and change the signal mask of the calling process.

    See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/sigprocmask.html}
     sigprocmask(2)}.

    Note: In multi-threaded programs, use {!pthread_sigmask} instead.

    @param action How to modify the signal mask.
    @param set
      The signal set to use, or [None] to only retrieve the current mask.
    @return The previous signal mask. *)
val sigprocmask : action -> sigset option -> sigset
