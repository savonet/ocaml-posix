(** POSIX time and clock functions.

    This module provides OCaml bindings to POSIX time functions defined in
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/time.h.html}
     time.h} and
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_time.h.html}
     sys/time.h}.

    It includes high-precision time structures, clock access, timers, and time
    conversion functions. *)

(** {1 Time Structures} *)

(** POSIX timespec: time with nanosecond precision. *)
module Timespec : sig
  (** Time value with seconds and nanoseconds. A normalized value has [tv_nsec]
      between [0] and [999999999] (inclusive). *)
  type t = private { tv_sec : int64; tv_nsec : int64 }

  (** [create sec nsec] creates a new normalized timespec. *)
  val create : int64 -> int64 -> t

  (** [add t1 t2] adds two timespec values, returning a normalized result. *)
  val add : t -> t -> t

  (** [sub t1 t2] subtracts [t2] from [t1], returning a normalized result. *)
  val sub : t -> t -> t

  (** [add_sec s t] adds [s] seconds to [t]. *)
  val add_sec : int64 -> t -> t

  (** [add_nsec ns t] adds [ns] nanoseconds to [t]. *)
  val add_nsec : int64 -> t -> t

  (** [sub_sec s t] subtracts [s] seconds from [t]. *)
  val sub_sec : int64 -> t -> t

  (** [sub_nsec ns t] subtracts [ns] nanoseconds from [t]. *)
  val sub_nsec : int64 -> t -> t

  (** [to_string t] returns a string in the form ["sec.nsec"]. *)
  val to_string : t -> string

  (** [compare t1 t2] compares two time values. Returns [0] if equal, negative
      if [t1 < t2], positive if [t1 > t2]. *)
  val compare : t -> t -> int
end

(** Interval timer specification using timespec. *)
module Itimerspec : sig
  type t = {
    it_interval : Timespec.t;  (** Timer interval *)
    it_value : Timespec.t;  (** Initial expiration *)
  }
end

(** POSIX timeval: time with microsecond precision. *)
module Timeval : sig
  (** Time value with seconds and microseconds. A normalized value has [tv_usec]
      between [0] and [999999] (inclusive). *)
  type t = private { tv_sec : int64; tv_usec : int64 }

  (** [create sec usec] creates a new normalized timeval. *)
  val create : int64 -> int64 -> t

  (** [add t1 t2] adds two timeval values, returning a normalized result. *)
  val add : t -> t -> t

  (** [sub t1 t2] subtracts [t2] from [t1], returning a normalized result. *)
  val sub : t -> t -> t

  (** [add_sec s t] adds [s] seconds to [t]. *)
  val add_sec : int64 -> t -> t

  (** [add_usec us t] adds [us] microseconds to [t]. *)
  val add_usec : int64 -> t -> t

  (** [sub_sec s t] subtracts [s] seconds from [t]. *)
  val sub_sec : int64 -> t -> t

  (** [sub_usec us t] subtracts [us] microseconds from [t]. *)
  val sub_usec : int64 -> t -> t

  (** [to_string t] returns a string in the form ["sec.usec"]. *)
  val to_string : t -> string

  (** [compare t1 t2] compares two time values. Returns [0] if equal, negative
      if [t1 < t2], positive if [t1 > t2]. *)
  val compare : t -> t -> int
end

(** POSIX broken-down time structure. *)
module Tm : sig
  (** Broken-down time with fields for seconds [0-60], minutes [0-59], hours
      [0-23], day of month [1-31], month [0-11], years since 1900, day of week
      [0-6] (Sunday = 0), day of year [0-365], and daylight saving flag
      (positive if DST, 0 if not, negative if unknown). *)
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

  (** [create sec min hour mday mon year wday yday isdst] creates a new
      broken-down time value. Returns [None] if arguments are invalid. *)
  val create :
    int -> int -> int -> int -> int -> int -> int -> int -> int -> t option

  (** [compare t1 t2] compares two time values considering year, month, day,
      hour, minute, second in that order. *)
  val compare : t -> t -> int
end

(** Interval timer value using timeval. *)
module Itimerval : sig
  type t = {
    it_interval : Timeval.t;  (** Timer interval *)
    it_value : Timeval.t;  (** Current value *)
  }
end

(** {1 Clock Types} *)

(** Clock identifiers for {!clock_gettime} and related functions. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/clock_getres.html}
     clock_getres(3)}. *)
type clock =
  [ `Realtime  (** System-wide real-time clock *)
  | `Monotonic  (** Monotonic clock that cannot be set *)
  | `Process_cputime  (** CPU time consumed by the process *)
  | `Thread_cputime  (** CPU time consumed by the thread *) ]

(** {1 Clock Functions} *)

(** Convert broken-down time to a string. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/asctime.html}
     asctime(3)}. *)
val asctime : Tm.t -> string

(** Get clock resolution. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/clock_getres.html}
     clock_getres(3)}. *)
val clock_getres : clock -> Timespec.t

(** Get current time from a clock. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/clock_gettime.html}
     clock_gettime(3)}. *)
val clock_gettime : clock -> Timespec.t

(** Set a clock's time (requires appropriate privileges). See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/clock_settime.html}
     clock_settime(3)}. *)
val clock_settime : clock -> Timespec.t -> unit

(** Convert Unix timestamp to a date/time string. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/ctime.html}
     ctime(3)}. *)
val ctime : int64 -> string

(** Convert Unix timestamp to broken-down UTC time. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/gmtime.html}
     gmtime(3)}. *)
val gmtime : int64 -> Tm.t

(** Convert Unix timestamp to broken-down local time. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/localtime.html}
     localtime(3)}. *)
val localtime : int64 -> Tm.t

(** Convert broken-down time to Unix timestamp. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/mktime.html}
     mktime(3)}. *)
val mktime : Tm.t -> int64

(** {1 Sleep Functions} *)

(** High-resolution sleep. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/nanosleep.html}
     nanosleep(3)}. *)
val nanosleep : Timespec.t -> unit

(** High-resolution sleep with clock selection. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/clock_nanosleep.html}
     clock_nanosleep(3)}.

    @param absolute
      If [true], sleep until the specified absolute time. If [false], sleep for
      the specified duration.
    @param clock The clock to use for timing. *)
val clock_nanosleep : absolute:bool -> clock:clock -> Timespec.t -> unit

(** {1 Interval Timers} *)

(** Interval timer types for {!getitimer} and {!setitimer}. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getitimer.html}
     getitimer(3)}. *)
type itimer =
  [ `Real  (** ITIMER_REAL: decrements in real time, delivers SIGALRM *)
  | `Virtual
    (** ITIMER_VIRTUAL: decrements in process virtual time, delivers SIGVTALRM
    *)
  | `Prof  (** ITIMER_PROF: decrements in process time, delivers SIGPROF *) ]

(** Get the value of an interval timer. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getitimer.html}
     getitimer(3)}. *)
val getitimer : itimer -> Itimerval.t

(** Set an interval timer and return its previous value. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/setitimer.html}
     setitimer(3)}. *)
val setitimer : itimer -> Itimerval.t -> Itimerval.t

(** {1 Time of Day} *)

(** Get the current time of day. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/gettimeofday.html}
     gettimeofday(3)}. *)
val gettimeofday : unit -> Timeval.t

(** {1 I/O Multiplexing} *)

(** Synchronous I/O multiplexing.

    See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/select.html}
     select(2)}.

    @param readfds File descriptors to check for readability.
    @param writefds File descriptors to check for writability.
    @param exceptfds File descriptors to check for exceptions.
    @param timeout Maximum time to wait, or [None] to block indefinitely.
    @return Triple of ready file descriptors [(readable, writable, exceptions)].
*)
val select :
  Unix.file_descr list ->
  Unix.file_descr list ->
  Unix.file_descr list ->
  Timeval.t option ->
  Unix.file_descr list * Unix.file_descr list * Unix.file_descr list

(** {1 File Times} *)

(** Set file access and modification times. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/utimes.html}
     utimes(3)}.

    @param ~last_access date and time of last access
    @param ~last_modification date and time of last modification
    @param path Path to the file. *)
val utimes : last_access:Timeval.t -> last_modification:Timeval.t -> string -> unit
