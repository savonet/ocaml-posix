(** High-level API to <sys/resource.h>. See:
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_resource.h.html}
     sys/resource.h} for details on data structures and functions. *)

(** {2 Resource limit constants} *)

(** CPU time limit in seconds *)
val rlimit_cpu : int

(** Maximum file size *)
val rlimit_fsize : int

(** Maximum data segment size *)
val rlimit_data : int

(** Maximum stack size *)
val rlimit_stack : int

(** Maximum core file size *)
val rlimit_core : int

(** Maximum number of open files *)
val rlimit_nofile : int

(** Maximum address space size *)
val rlimit_as : int

(** Special value meaning no limit *)
val rlim_infinity : Unsigned.uint64

(** {2 Resource usage constants} *)

(** Current process *)
val rusage_self : int

(** All terminated and waited-for children *)
val rusage_children : int

(** {2 Priority constants} *)

(** Process priority *)
val prio_process : int

(** Process group priority *)
val prio_pgrp : int

(** User priority *)
val prio_user : int

(** {2 Resource limit types} *)

type rlimit = {
  rlim_cur : Unsigned.uint64;  (** Current (soft) limit *)
  rlim_max : Unsigned.uint64;  (** Maximum (hard) limit *)
}

(** {2 Resource usage types} *)

type rusage = {
  ru_utime : Posix_time2.Timeval.t;  (** User CPU time used *)
  ru_stime : Posix_time2.Timeval.t;  (** System CPU time used *)
  ru_maxrss : int64;  (** Maximum resident set size *)
  ru_ixrss : int64;  (** Integral shared memory size *)
  ru_idrss : int64;  (** Integral unshared data size *)
  ru_isrss : int64;  (** Integral unshared stack size *)
  ru_minflt : int64;  (** Page reclaims (soft page faults) *)
  ru_majflt : int64;  (** Page faults (hard page faults) *)
  ru_nswap : int64;  (** Swaps *)
  ru_inblock : int64;  (** Block input operations *)
  ru_oublock : int64;  (** Block output operations *)
  ru_msgsnd : int64;  (** IPC messages sent *)
  ru_msgrcv : int64;  (** IPC messages received *)
  ru_nsignals : int64;  (** Signals received *)
  ru_nvcsw : int64;  (** Voluntary context switches *)
  ru_nivcsw : int64;  (** Involuntary context switches *)
}

(** {2 Resource limit functions} *)

(** [getrlimit resource] returns the current resource limits for [resource].
    @raise Unix.Unix_error on failure *)
val getrlimit : int -> rlimit

(** [setrlimit resource limits] sets the resource limits for [resource].
    @raise Unix.Unix_error on failure *)
val setrlimit : int -> rlimit -> unit

(** {2 Resource usage functions} *)

(** [getrusage who] returns resource usage statistics. [who] should be
    {!rusage_self} or {!rusage_children}.
    @raise Unix.Unix_error on failure *)
val getrusage : int -> rusage

(** {2 Priority functions} *)

(** [getpriority which who] returns the priority of process, process group, or
    user. [which] should be {!prio_process}, {!prio_pgrp}, or {!prio_user}.
    @raise Unix.Unix_error on failure *)
val getpriority : int -> int -> int

(** [setpriority which who prio] sets the priority.
    @raise Unix.Unix_error on failure *)
val setpriority : int -> int -> int -> unit
