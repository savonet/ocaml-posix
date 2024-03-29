open Ctypes

module Def (F : Cstubs.FOREIGN) = struct
  open F
  module Types = Posix_time2_types.Def (Posix_time2_generated_types)
  open Types

  let asctime = foreign "asctime" (ptr Tm.t @-> returning string)

  let clock_getres =
    foreign "clock_getres"
      (Posix_types.clockid_t @-> ptr Timespec.t @-> returning int)

  let clock_gettime =
    foreign "clock_gettime"
      (Posix_types.clockid_t @-> ptr Timespec.t @-> returning int)

  let clock_settime =
    foreign "clock_settime"
      (Posix_types.clockid_t @-> ptr Timespec.t @-> returning int)

  let ctime = foreign "ctime" (ptr Posix_types.time_t @-> returning string)
  let gmtime = foreign "gmtime" (ptr Posix_types.time_t @-> returning (ptr Tm.t))

  let localtime =
    foreign "localtime" (ptr Posix_types.time_t @-> returning (ptr Tm.t))

  let mktime = foreign "mktime" (ptr Tm.t @-> returning Posix_types.time_t)

  let nanosleep =
    foreign "nanosleep" (ptr Timespec.t @-> ptr void @-> returning int)

  let clock_nanosleep =
    foreign "clock_nanosleep"
      (Posix_types.clockid_t @-> int @-> ptr Timespec.t @-> ptr void
     @-> returning int)

  let getitimer = foreign "getitimer" (int @-> ptr Itimerval.t @-> returning int)

  let setitimer =
    foreign "setitimer"
      (int @-> ptr Itimerval.t @-> ptr Itimerval.t @-> returning int)

  let gettimeofday =
    foreign "gettimeofday" (ptr Timeval.t @-> ptr void @-> returning int)

  let fd_zero =
    foreign "ocaml_posix_time2_fd_zero"
      (ptr Posix_time2_types.fd_set @-> returning void)

  let fd_set =
    foreign "ocaml_posix_time2_fd_set"
      (int @-> ptr Posix_time2_types.fd_set @-> returning void)

  let fd_isset =
    foreign "ocaml_posix_time2_fd_isset"
      (int @-> ptr Posix_time2_types.fd_set @-> returning int)

  let fd_clr =
    foreign "ocaml_posix_time2_fd_clr"
      (int @-> ptr Posix_time2_types.fd_set @-> returning void)

  let select =
    foreign "select"
      (int
      @-> ptr Posix_time2_types.fd_set
      @-> ptr Posix_time2_types.fd_set
      @-> ptr Posix_time2_types.fd_set
      @-> ptr Timeval.t @-> returning int)

  let utimes = foreign "utimes" (string @-> ptr Timeval.t @-> returning int)
end
