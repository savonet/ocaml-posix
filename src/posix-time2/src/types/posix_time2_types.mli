open Ctypes

val itimer_real : int
val itimer_virtual : int
val itimer_prof : int

type fd_set

val fd_set : fd_set typ
val fd_setsize : int
val clock_monotonic : Posix_types.clockid_t
val clock_realtime : Posix_types.clockid_t
val clock_process_cputime_id : Posix_types.clockid_t
val clock_thread_cputime_id : Posix_types.clockid_t
val timer_abstime : int

module Def (S : Cstubs.Types.TYPE) : sig
  module Tm : sig
    type t

    val t : t structure S.typ
    val tm_sec : (int, t structure) S.field
    val tm_min : (int, t structure) S.field
    val tm_hour : (int, t structure) S.field
    val tm_mday : (int, t structure) S.field
    val tm_mon : (int, t structure) S.field
    val tm_year : (int, t structure) S.field
    val tm_wday : (int, t structure) S.field
    val tm_yday : (int, t structure) S.field
    val tm_isdst : (int, t structure) S.field
  end

  module Timespec : sig
    type t

    val t : t structure S.typ
    val tv_sec : (Posix_types.time_t, t structure) S.field
    val tv_nsec : (Signed.long, t structure) S.field
  end

  module Timeval : sig
    type t

    val t : t structure S.typ
    val tv_sec : (Posix_types.time_t, t structure) S.field
    val tv_usec : (Posix_types.suseconds_t, t structure) S.field
  end

  module Itimerval : sig
    type t

    val t : t structure S.typ
    val it_interval : (Timeval.t structure, t structure) S.field
    val it_value : (Timeval.t structure, t structure) S.field
  end
end
