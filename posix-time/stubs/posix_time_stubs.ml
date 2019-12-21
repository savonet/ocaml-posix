open Ctypes

module Def (F : Cstubs.FOREIGN) = struct
  open F

  module Types = Posix_time_types.Def(Posix_time_generated_types)

  open Types

  let asctime = foreign "asctime" (ptr Tm.t @-> (returning string))

  let clock_getres = foreign "clock_getres" (Posix_time_types.clockid_t @-> ptr Timespec.t @-> (returning int))
  let clock_gettime = foreign "clock_gettime" (Posix_time_types.clockid_t @-> ptr Timespec.t @-> (returning int))
  let clock_settime = foreign "clock_settime" (Posix_time_types.clockid_t @-> ptr Timespec.t @-> (returning int))

  let ctime = foreign "ctime" (PosixTypes.time_t @-> (returning string))

  let gmtime = foreign "gmtime" (PosixTypes.time_t @-> (returning (ptr Tm.t)))
  let localtime = foreign "localtime" (PosixTypes.time_t @-> (returning (ptr Tm.t)))
  let mktime = foreign "mktime" (ptr Tm.t @-> (returning PosixTypes.time_t))

  let nanosleep = foreign "nanosleep" (ptr Timespec.t @-> ptr void @-> (returning int))

  let getitimer = foreign "getitimer" (int @-> ptr Itimerval.t @-> (returning int))
  let setitimer = foreign "setitimer" (int @-> ptr Itimerval.t @-> ptr Itimerval.t @-> (returning int))

  let gettimeofday = foreign "gettimeofday" (ptr Timeval.t @-> ptr void @-> (returning int))  
  
  let fd_zero = foreign "ocaml_posix_time_fd_zero" (ptr Posix_time_types.fd_set @-> (returning void))
  let fd_set = foreign "ocaml_posix_time_fd_set" (int @-> ptr Posix_time_types.fd_set @-> (returning void))
  let fd_isset = foreign "ocaml_posix_time_fd_isset" (int @-> ptr Posix_time_types.fd_set @-> (returning int))
  let fd_clr = foreign "ocaml_posix_time_fd_clr" (int @-> ptr Posix_time_types.fd_set @-> (returning void))

  let select = foreign "select" (int @-> ptr Posix_time_types.fd_set @-> ptr Posix_time_types.fd_set @-> ptr Posix_time_types.fd_set @-> ptr Timeval.t @-> (returning int))

  let  utimes = foreign "utimes" (string @-> ptr Timeval.t @-> (returning int))
end
