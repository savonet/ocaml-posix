open Ctypes

(** Resource limit constants *)
val rlimit_cpu : int

val rlimit_fsize : int
val rlimit_data : int
val rlimit_stack : int
val rlimit_core : int
val rlimit_nofile : int
val rlimit_as : int

(** rusage who constants *)
val rusage_self : int

val rusage_children : int

(** Priority who constants *)
val prio_process : int

val prio_pgrp : int
val prio_user : int

(** Special rlimit value *)
val rlim_infinity : Unsigned.uint64

(** Structure definitions *)
module Def (S : Cstubs.Types.TYPE) : sig
  module Time2_types : module type of Posix_time2_types.Def (S)

  val rlim_t : Unsigned.uint64 S.typ

  module Rlimit : sig
    type t

    val t : t structure S.typ
    val rlim_cur : (Unsigned.uint64, t structure) S.field
    val rlim_max : (Unsigned.uint64, t structure) S.field
  end

  module Rusage : sig
    type t

    val t : t structure S.typ
    val ru_utime : (Time2_types.Timeval.t structure, t structure) S.field
    val ru_stime : (Time2_types.Timeval.t structure, t structure) S.field
    val ru_maxrss : (Signed.long, t structure) S.field
    val ru_ixrss : (Signed.long, t structure) S.field
    val ru_idrss : (Signed.long, t structure) S.field
    val ru_isrss : (Signed.long, t structure) S.field
    val ru_minflt : (Signed.long, t structure) S.field
    val ru_majflt : (Signed.long, t structure) S.field
    val ru_nswap : (Signed.long, t structure) S.field
    val ru_inblock : (Signed.long, t structure) S.field
    val ru_oublock : (Signed.long, t structure) S.field
    val ru_msgsnd : (Signed.long, t structure) S.field
    val ru_msgrcv : (Signed.long, t structure) S.field
    val ru_nsignals : (Signed.long, t structure) S.field
    val ru_nvcsw : (Signed.long, t structure) S.field
    val ru_nivcsw : (Signed.long, t structure) S.field
  end

  type rlimit = Rlimit.t structure
  type rusage = Rusage.t structure

  val rlimit_t : rlimit S.typ
  val rusage_t : rusage S.typ
end
