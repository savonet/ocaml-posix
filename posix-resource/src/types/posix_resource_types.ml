open Ctypes

module Constants =
  Posix_resource_constants.Def (Posix_resource_generated_constants)

(* Re-export constants *)
let rlimit_cpu = Constants.rlimit_cpu
let rlimit_fsize = Constants.rlimit_fsize
let rlimit_data = Constants.rlimit_data
let rlimit_stack = Constants.rlimit_stack
let rlimit_core = Constants.rlimit_core
let rlimit_nofile = Constants.rlimit_nofile
let rlimit_as = Constants.rlimit_as
let rusage_self = Constants.rusage_self
let rusage_children = Constants.rusage_children
let prio_process = Constants.prio_process
let prio_pgrp = Constants.prio_pgrp
let prio_user = Constants.prio_user
let rlim_infinity = Constants.rlim_infinity

module Def (S : Cstubs.Types.TYPE) = struct
  (* Import timeval type from posix-time2 *)
  module Time2_types = Posix_time2_types.Def (S)

  (* rlim_t type - typically unsigned long or uint64 *)
  let rlim_t = S.typedef S.uint64_t "rlim_t"

  module Rlimit = struct
    type t = unit

    let t = S.structure "rlimit"
    let rlim_cur = S.field t "rlim_cur" rlim_t
    let rlim_max = S.field t "rlim_max" rlim_t
    let () = S.seal t
  end

  module Rusage = struct
    type t = unit

    let t = S.structure "rusage"
    let ru_utime = S.field t "ru_utime" Time2_types.Timeval.t
    let ru_stime = S.field t "ru_stime" Time2_types.Timeval.t
    let ru_maxrss = S.field t "ru_maxrss" S.long
    let ru_ixrss = S.field t "ru_ixrss" S.long
    let ru_idrss = S.field t "ru_idrss" S.long
    let ru_isrss = S.field t "ru_isrss" S.long
    let ru_minflt = S.field t "ru_minflt" S.long
    let ru_majflt = S.field t "ru_majflt" S.long
    let ru_nswap = S.field t "ru_nswap" S.long
    let ru_inblock = S.field t "ru_inblock" S.long
    let ru_oublock = S.field t "ru_oublock" S.long
    let ru_msgsnd = S.field t "ru_msgsnd" S.long
    let ru_msgrcv = S.field t "ru_msgrcv" S.long
    let ru_nsignals = S.field t "ru_nsignals" S.long
    let ru_nvcsw = S.field t "ru_nvcsw" S.long
    let ru_nivcsw = S.field t "ru_nivcsw" S.long
    let () = S.seal t
  end

  type rlimit = Rlimit.t structure
  type rusage = Rusage.t structure

  let rlimit_t : rlimit S.typ = Rlimit.t
  let rusage_t : rusage S.typ = Rusage.t
end
