open Ctypes

module Constants = Posix_time_constants.Def(Posix_time_generated_constants)

include Constants

type fd_set = unit Ctypes.abstract
let fd_set =
  Ctypes.abstract ~name:"fd_set" ~size:fd_set_size
                  ~alignment:fd_set_alignment

module type Clockid = sig
  type t
  val t : t typ
  val int64_of_clockid : t -> int64
  val clockid_of_int64 : int64 -> t
end

let clockid : (module Clockid)  =
    match Constants.clockid_len with
      | 1 ->  (module struct
                 type t = int
                 let t = int8_t
                 let int64_of_clockid = Int64.of_int
                 let clockid_of_int64 = Int64.to_int
               end)
      | 2 -> (module struct
                 type t = int
                 let t = int16_t
                 let int64_of_clockid = Int64.of_int
                 let clockid_of_int64 = Int64.to_int
               end)
      | 4 -> (module struct
                 type t = int32
                 let t = int32_t
                 let int64_of_clockid = Int64.of_int32
                 let clockid_of_int64 = Int64.to_int32
               end)
      | 8 -> (module struct
                 type t = int64
                 let t = int64_t
                 let int64_of_clockid v = v
                 let clockid_of_int64 v = v
               end)
      | _ -> assert false

module Clockid = (val clockid : Clockid)

type clockid_t = Clockid.t
let clockid_t = typedef Clockid.t "clockid_t"
let int64_of_clockid = Clockid.int64_of_clockid
let clockid_of_int64 = Clockid.clockid_of_int64

module Def (S : Cstubs.Types.TYPE) = struct
  module Tm = struct
    type t = unit
    let t =
      S.structure "tm"
    let tm_sec =
      S.field t "tm_sec" S.int
    let tm_min =
      S.field t "tm_min" S.int
    let tm_hour =
      S.field t "tm_hour" S.int
    let tm_mday =
      S.field t "tm_mday" S.int
    let tm_mon =
      S.field t "tm_mon" S.int
    let tm_year =
      S.field t "tm_year" S.int
    let tm_wday =
      S.field t "tm_wday" S.int
    let tm_yday =
      S.field t "tm_yday" S.int
    let tm_isdst =
      S.field t "tm_isdst" S.int
    let () =
      S.seal t
  end

  module Timespec = struct
    type t = unit
    let t =
      S.structure "timespec"
    let tv_sec =
      S.field t "tv_sec" (S.lift_typ PosixTypes.time_t)
    let tv_nsec =
      S.field t "tv_nsec" (S.lift_typ long)
    let () =
      S.seal t
  end

  module Timeval = struct
    type t = unit
    let t =
      S.structure "timeval"
    let tv_sec =
      S.field t "tv_sec" (S.lift_typ PosixTypes.time_t)
    let tv_usec =
      S.field t "tv_usec" (S.lift_typ PosixTypes.suseconds_t)
    let () =
      S.seal t
  end

  module Itimerval = struct
    type t = unit
    let t =
      S.structure "itimerval"
    let it_interval =
      S.field t "it_interval" Timeval.t
    let it_value =
      S.field t "it_value" Timeval.t
    let () =
      S.seal t
  end
end
