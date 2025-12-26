open Ctypes
include Posix_resource_stubs.Def (Posix_resource_generated_stubs)
include Posix_resource_types

(* High-level types *)
type rlimit = { rlim_cur : Unsigned.uint64; rlim_max : Unsigned.uint64 }

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
  let rlim = make Types.Rlimit.t in
  ignore
    (Posix_errno.raise_on_neg ~call:"getrlimit" (fun () ->
         getrlimit resource (addr rlim)));
  from_rlimit rlim

let setrlimit resource limits =
  let rlim = to_rlimit limits in
  ignore
    (Posix_errno.raise_on_neg ~call:"setrlimit" (fun () ->
         setrlimit resource (addr rlim)))

(* Resource usage functions *)
let getrusage who =
  let ru = make Types.Rusage.t in
  ignore
    (Posix_errno.raise_on_neg ~call:"getrusage" (fun () ->
         getrusage who (addr ru)));
  from_rusage ru

(* Priority functions *)
let getpriority which who =
  Posix_errno.raise_on_error ~call:"getpriority"
    (fun () -> getpriority which who)
    (fun n -> n = -1)

let setpriority which who prio =
  ignore
    (Posix_errno.raise_on_neg ~call:"setpriority" (fun () ->
         setpriority which who prio))
