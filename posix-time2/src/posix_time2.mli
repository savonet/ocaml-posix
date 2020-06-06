(** High-level API to <time.h> and <sys/time.h>.
    See: {{:https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/time.h.html} time.h}
    and {{:https://pubs.opengroup.org/onlinepubs/7908799/xsh/systime.h.html} systime.h}
    for an explanation about the data structures and functions. *)

module Timespec : sig
  (** POSIX timespec time specifier with seconds and nanoseconds. A normalized
      value of type [t] must have a value of [tv_nsec] between [0] and
      [1000000000] (exclusive). *)
  type t = private { tv_sec : int64; tv_nsec : int64 }

  (** [create sec nsec] creates a new normalized timespec with [sec] seconds
      and [nsec] nanoseconds. *)
  val create : int64 -> int64 -> t

  (** [add t1 t2] adds the two timespec values, returning a normalized value *)
  val add : t -> t -> t

  (** [sub t1 t2] subtracts [t2] from [t1], creating a new normalized time
      value. *)
  val sub : t -> t -> t

  (** [add_sec s t] adds [s] seconds to [t]. *)
  val add_sec : int64 -> t -> t

  (** [add_sec ns t] adds [ns] nanoseconds to [t]. *)
  val add_nsec : int64 -> t -> t

  (** [sub_sec s t] subtracts [s] seconds from [t]. *)
  val sub_sec : int64 -> t -> t

  (** [sub_sec ns t] subtracts [ns] nanoseconds from [t]. *)
  val sub_nsec : int64 -> t -> t

  (** [to_string t] creates a string of the form "sec.nsec". *)
  val to_string : t -> string

  (** [compare t1 t2] compares the two time values [t1] and [t2]. It returns
      [0] if [t1] is equal to [2], a negative integer if [t1] is less than [t2],
      and a positive integer if [t1] is greater than [t2]. *)
  val compare : t -> t -> int
end

module Itimerspec : sig
  type t = { it_interval : Timespec.t; it_value : Timespec.t }
end

module Timeval : sig
  (** POSIX timeval time value with seconds and microseconds. A normalized
      value of type [t] must have a value of [tv_usec] between [0] and
      [1000000] (exclusive). *)
  type t = private { tv_sec : int64; tv_usec : int64 }

  (** [create sec usec] creates a new normalized timespec with [sec] seconds
      and [usec] microseconds. *)
  val create : int64 -> int64 -> t

  (** [add t1 t2] adds the two timespec values, returning a normalized value *)
  val add : t -> t -> t

  (** [sub t1 t2] subtracts [t2] from [t1], creating a new normalized time
      value. *)
  val sub : t -> t -> t

  (** [add_sec s t] adds [s] seconds to [t]. *)
  val add_sec : int64 -> t -> t

  (** [add_sec us t] adds [us] microseconds to [t]. *)
  val add_usec : int64 -> t -> t

  (** [sub_sec s t] subtracts [s] seconds from [t]. *)
  val sub_sec : int64 -> t -> t

  (** [sub_sec us t] subtracts [us] microseconds from [t]. *)
  val sub_usec : int64 -> t -> t

  (** [to_string t] creates a string of the form "sec.usec". *)
  val to_string : t -> string

  (** [compare t1 t2] compares the two time values [t1] and [t2]. It returns
      [0] if [t1] is equal to [2], a negative integer if [t1] is less than [t2],
      and a positive integer if [t1] is greater than [t2]. *)
  val compare : t -> t -> int
end

module Tm : sig
  (** POSIX tm value with seconds [0,61], minutes [0,59], hours [0,23], day of
    month [0,31], month of year [0,11], years since 1900, day of week [0,6]
    (Sunday = 0), day of year [0,365] and daylight saving flag.
    The daylight saving flag is positive if daylight saving is in effect and 0
    if not. In case this information is not available, it has a negative value.
  *)
  type t = private {
    tm_sec : int;
    tm_min : int;
    tm_hour : int;
    tm_mday : int;
    tm_mon : int;
    tm_year : int;
    tm_wday : int;
    tm_yday : int;
    tm_isdst : int;
  }

  (** [create tm_sec tm_min tm_hour tm_mday rm_mon tm_year tm_wday tm_yday tm_isdst]
    creates a new time value if the all arguments suffice the aforementioned
    predicates. Otherwise [create] will return [None]. *)
  val create :
    int -> int -> int -> int -> int -> int -> int -> int -> int -> t option

  (** [compare t1 t2] compares the two time values [t1] and [t2]. It returns
    [0] if [t1] is equal to [2], a negative integer if [t1] is less than [t2],
    and a positive integer if [t1] is greater than [t2].
    [compare] considers tm_year, tm_mon, tm_mday, tm_hour, tm_min, tm_sec in
    the given order. *)
  val compare : t -> t -> int
end

module Itimerval : sig
  type t = { it_interval : Timeval.t; it_value : Timeval.t }
end

type clock = [ `Realtime | `Monotonic | `Process_cputime | `Thread_cputime ]

val asctime : Tm.t -> string
val clock_getres : clock -> Timespec.t
val clock_gettime : clock -> Timespec.t
val clock_settime : clock -> Timespec.t -> unit
val ctime : int64 -> string
val gmtime : int64 -> Tm.t
val localtime : int64 -> Tm.t
val mktime : Tm.t -> int64
val nanosleep : Timespec.t -> unit

type itimer = [ `Real | `Virtual | `Prof ]

val getitimer : itimer -> Itimerval.t
val setitimer : itimer -> Itimerval.t -> Itimerval.t
val gettimeofday : unit -> Timeval.t

(* [select] behaviour should be exactly the same as the C equivalent.
 * Passing [None] for [timeval] is equivalent to passing a [NULL] pointer
 * in a C call. *)
val select :
  Unix.file_descr list ->
  Unix.file_descr list ->
  Unix.file_descr list ->
  Timeval.t option ->
  Unix.file_descr list * Unix.file_descr list * Unix.file_descr list

val utimes : string -> Timeval.t -> unit
