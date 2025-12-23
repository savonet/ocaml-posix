open Ctypes
include Posix_resource_stubs.Def (Posix_resource_generated_stubs)
module Types = Posix_resource_types.Def (Posix_resource_generated_types)

(* Re-export constants *)
let rlimit_cpu = Posix_resource_types.rlimit_cpu
let rlimit_fsize = Posix_resource_types.rlimit_fsize
let rlimit_data = Posix_resource_types.rlimit_data
let rlimit_stack = Posix_resource_types.rlimit_stack
let rlimit_core = Posix_resource_types.rlimit_core
let rlimit_nofile = Posix_resource_types.rlimit_nofile
let rlimit_as = Posix_resource_types.rlimit_as

let rusage_self = Posix_resource_types.rusage_self
let rusage_children = Posix_resource_types.rusage_children

let prio_process = Posix_resource_types.prio_process
let prio_pgrp = Posix_resource_types.prio_pgrp
let prio_user = Posix_resource_types.prio_user

let rlim_infinity = Posix_resource_types.rlim_infinity

(* High-level types *)
type rlimit = {
  rlim_cur : Unsigned.uint64;
  rlim_max : Unsigned.uint64;
}

type rusage = {
  ru_utime : Posix_time2.Timeval.t;
  ru_stime : Posix_time2.Timeval.t;
  ru_maxrss : int64;
  ru_ixrss : int64;
  ru_idrss : int64;
  ru_isrss : int64;
  ru_minflt : int64;
  ru_majflt : int64;
  ru_nswap : int64;
  ru_inblock : int64;
  ru_oublock : int64;
  ru_msgsnd : int64;
  ru_msgrcv : int64;
  ru_nsignals : int64;
  ru_nvcsw : int64;
  ru_nivcsw : int64;
}

(* Error handling helpers *)
let wrap_int_result f =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          match f () with x when x < 0 -> None | _ -> Some ()))

let wrap_result f =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          let (ret, result) = f () in
          match ret with x when x < 0 -> None | _ -> Some result))

(* Conversion helpers *)
let from_rlimit rlim =
  let get f = getf rlim f in
  { rlim_cur = get Types.Rlimit.rlim_cur; rlim_max = get Types.Rlimit.rlim_max }

let to_rlimit { rlim_cur; rlim_max } =
  let rlim = make Types.Rlimit.t in
  setf rlim Types.Rlimit.rlim_cur rlim_cur;
  setf rlim Types.Rlimit.rlim_max rlim_max;
  rlim

let from_rusage ru =
  let get f = getf ru f in
  let get_timeval f =
    let tv = get f in
    let tv_sec =
      Posix_types.Time.to_int64 (getf tv Types.Time2_types.Timeval.tv_sec)
    in
    let tv_usec =
      Posix_types.Suseconds.to_int64 (getf tv Types.Time2_types.Timeval.tv_usec)
    in
    Posix_time2.Timeval.create tv_sec tv_usec
  in
  {
    ru_utime = get_timeval Types.Rusage.ru_utime;
    ru_stime = get_timeval Types.Rusage.ru_stime;
    ru_maxrss = Signed.Long.to_int64 (get Types.Rusage.ru_maxrss);
    ru_ixrss = Signed.Long.to_int64 (get Types.Rusage.ru_ixrss);
    ru_idrss = Signed.Long.to_int64 (get Types.Rusage.ru_idrss);
    ru_isrss = Signed.Long.to_int64 (get Types.Rusage.ru_isrss);
    ru_minflt = Signed.Long.to_int64 (get Types.Rusage.ru_minflt);
    ru_majflt = Signed.Long.to_int64 (get Types.Rusage.ru_majflt);
    ru_nswap = Signed.Long.to_int64 (get Types.Rusage.ru_nswap);
    ru_inblock = Signed.Long.to_int64 (get Types.Rusage.ru_inblock);
    ru_oublock = Signed.Long.to_int64 (get Types.Rusage.ru_oublock);
    ru_msgsnd = Signed.Long.to_int64 (get Types.Rusage.ru_msgsnd);
    ru_msgrcv = Signed.Long.to_int64 (get Types.Rusage.ru_msgrcv);
    ru_nsignals = Signed.Long.to_int64 (get Types.Rusage.ru_nsignals);
    ru_nvcsw = Signed.Long.to_int64 (get Types.Rusage.ru_nvcsw);
    ru_nivcsw = Signed.Long.to_int64 (get Types.Rusage.ru_nivcsw);
  }

(* Resource limit functions *)
let getrlimit resource =
  wrap_result (fun () ->
      let rlim = make Types.Rlimit.t in
      let ret = getrlimit resource (addr rlim) in
      (ret, from_rlimit rlim))

let setrlimit resource limits =
  wrap_int_result (fun () ->
      let rlim = to_rlimit limits in
      setrlimit resource (addr rlim))

(* Resource usage functions *)
let getrusage who =
  wrap_result (fun () ->
      let ru = make Types.Rusage.t in
      let ret = getrusage who (addr ru) in
      (ret, from_rusage ru))

(* Priority functions *)
let getpriority which who =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno ~call:"getpriority" (fun () ->
          let ret = getpriority which who in
          Some ret))

let setpriority which who prio =
  wrap_int_result (fun () -> setpriority which who prio)
