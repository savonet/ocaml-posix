open Ctypes

val itimer_real: int
val itimer_virtual: int
val itimer_prof: int

type fd_set
val fd_set : fd_set typ
val fd_setsize: int

type clockid_t
val clockid_t : clockid_t typ
val int64_of_clockid : clockid_t -> Int64.t
val clockid_of_int64 : Int64.t -> clockid_t
val clock_monotonic: int
val clock_realtime: int
val clock_process_cputime_id: int
val clock_thread_cputime_id: int

module Def (S : Cstubs.Types.TYPE) : sig 
  module Tm : sig
    type t
    val t : t structure S.typ
    val tm_sec   : (int, t structure) S.field
    val tm_min   : (int, t structure) S.field
    val tm_hour  : (int, t structure) S.field
    val tm_mday  : (int, t structure) S.field
    val tm_mon   : (int, t structure) S.field
    val tm_year  : (int, t structure) S.field
    val tm_wday  : (int, t structure) S.field
    val tm_yday  : (int, t structure) S.field
    val tm_isdst : (int, t structure) S.field
  end

  module Timespec : sig
    type t
    val t : t structure S.typ
    val tv_sec  : (PosixTypes.time_t, t structure) S.field
    val tv_nsec : (Signed.long, t structure) S.field
  end

  module Timeval : sig
    type t
    val t : t structure S.typ
    val tv_sec  : (PosixTypes.time_t, t structure) S.field
    val tv_usec : (PosixTypes.suseconds_t, t structure) S.field
  end

  module Itimerval : sig
    type t
    val t : t structure S.typ
    val it_interval : (Timeval.t structure, t structure) S.field
    val it_value    : (Timeval.t structure, t structure) S.field
  end
end
