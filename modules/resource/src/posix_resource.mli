(** POSIX resource usage and limits.

    This module provides OCaml bindings to POSIX resource functions defined in
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_resource.h.html}
     sys/resource.h}.

    It includes functions for querying and setting resource limits, getting
    resource usage statistics, and managing process priorities.

    {2 Example}

    {[
      (* Get resource usage for current process *)
      let usage = Posix_resource.getrusage rusage_self in
      Printf.printf "User CPU time: %s\n"
        (Posix_time2.Timeval.to_string usage.ru_utime);
      Printf.printf "Max RSS: %Ld KB\n" usage.ru_maxrss;

      (* Get file descriptor limit *)
      let limits = Posix_resource.getrlimit rlimit_nofile in
      Printf.printf "Max open files: %s\n"
        (Unsigned.UInt64.to_string limits.rlim_cur)
    ]} *)

(** {1 Resource Limit Constants} *)

(** CPU time limit in seconds (RLIMIT_CPU). *)
val rlimit_cpu : int

(** Maximum file size in bytes (RLIMIT_FSIZE). *)
val rlimit_fsize : int

(** Maximum data segment size (RLIMIT_DATA). *)
val rlimit_data : int

(** Maximum stack size (RLIMIT_STACK). *)
val rlimit_stack : int

(** Maximum core file size (RLIMIT_CORE). *)
val rlimit_core : int

(** Maximum number of open files (RLIMIT_NOFILE). *)
val rlimit_nofile : int

(** Maximum address space size (RLIMIT_AS). *)
val rlimit_as : int

(** Special value meaning no limit (RLIM_INFINITY). *)
val rlim_infinity : Unsigned.uint64

(** {1 Resource Usage Constants} *)

(** Current process (RUSAGE_SELF). *)
val rusage_self : int

(** All terminated and waited-for children (RUSAGE_CHILDREN). *)
val rusage_children : int

(** {1 Priority Constants} *)

(** Process priority (PRIO_PROCESS). *)
val prio_process : int

(** Process group priority (PRIO_PGRP). *)
val prio_pgrp : int

(** User priority (PRIO_USER). *)
val prio_user : int

(** {1 Resource Limit Types} *)

type rlimit = {
  rlim_cur : Unsigned.uint64;  (** Current (soft) limit *)
  rlim_max : Unsigned.uint64;  (** Maximum (hard) limit *)
}

(** {1 Resource Usage Types} *)

(** Resource usage information returned by {!getrusage}. Corresponds to POSIX
    [struct rusage]. *)
type rusage = {
  ru_utime : Posix_time2.Timeval.t;
  ru_stime : Posix_time2.Timeval.t;
  ru_maxrss : int64;
  ru_ixrss : int64;
  ru_idrss : int64;
  ru_isrss : int64;
  ru_minflt : int64;
  ru_majflt : int64;
  ru_nswap : int64;
  ru_inblock : int64;
  ru_oublock : int64;
  ru_msgsnd : int64;
  ru_msgrcv : int64;
  ru_nsignals : int64;
  ru_nvcsw : int64;
  ru_nivcsw : int64;
}

(** {1 Resource Limit Functions} *)

(** Get resource limits.

    See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getrlimit.html}
     getrlimit(2)}.

    @param resource One of the [rlimit_*] constants.
    @return The current soft and hard limits.
    @raise Unix.Unix_error on failure. *)
val getrlimit : int -> rlimit

(** Set resource limits.

    See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/setrlimit.html}
     setrlimit(2)}.

    @param resource One of the [rlimit_*] constants.
    @param limits The new soft and hard limits.
    @raise Unix.Unix_error on failure. *)
val setrlimit : int -> rlimit -> unit

(** {1 Resource Usage Functions} *)

(** Get resource usage statistics.

    See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getrusage.html}
     getrusage(2)}.

    @param who {!rusage_self} or {!rusage_children}.
    @return Resource usage information.
    @raise Unix.Unix_error on failure. *)
val getrusage : int -> rusage

(** {1 Priority Functions} *)

(** Get process scheduling priority.

    See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getpriority.html}
     getpriority(2)}.

    @param which {!prio_process}, {!prio_pgrp}, or {!prio_user}.
    @param who Process ID, process group ID, or user ID (0 for current).
    @return The priority value.
    @raise Unix.Unix_error on failure. *)
val getpriority : int -> int -> int

(** Set process scheduling priority.

    See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/setpriority.html}
     setpriority(2)}.

    @param which {!prio_process}, {!prio_pgrp}, or {!prio_user}.
    @param who Process ID, process group ID, or user ID (0 for current).
    @param prio The new priority value.
    @raise Unix.Unix_error on failure. *)
val setpriority : int -> int -> int -> unit
