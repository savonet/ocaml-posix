open Ctypes

include Posix_time_stubs.Def(Posix_time_generated_stubs)

type tm = {
  tm_sec:   int;
  tm_min:   int;
  tm_hour:  int;
  tm_mday:  int;
  tm_mon:   int;
  tm_year:  int;
  tm_wday:  int;
  tm_yday:  int;
  tm_isdst: bool
}

let to_tm tm =
  let get f = getf tm f in
  { tm_sec = get Types.Tm.tm_sec;
    tm_min = get Types.Tm.tm_min;
    tm_hour = get Types.Tm.tm_hour;
    tm_mday = get Types.Tm.tm_mday;
    tm_mon = get Types.Tm.tm_mon;
    tm_year = get Types.Tm.tm_year;
    tm_wday = get Types.Tm.tm_wday;
    tm_yday = get Types.Tm.tm_yday;
    tm_isdst = get Types.Tm.tm_isdst = 0 }

let from_tm tm =
  let _tm = make Types.Tm.t in
  setf _tm Types.Tm.tm_sec tm.tm_sec;
  setf _tm Types.Tm.tm_min tm.tm_min;
  setf _tm Types.Tm.tm_hour tm.tm_hour;
  setf _tm Types.Tm.tm_mday tm.tm_mday;
  setf _tm Types.Tm.tm_mon tm.tm_mon;
  setf _tm Types.Tm.tm_year tm.tm_year;
  setf _tm Types.Tm.tm_wday tm.tm_wday;
  setf _tm Types.Tm.tm_yday tm.tm_yday;
  setf _tm Types.Tm.tm_isdst (if tm.tm_isdst then 1 else 0);
  _tm


type timespec = {
  tv_sec:  int64;
  tv_nsec: int64
}

type clock = [
  | `Realtime
  | `Monotonic
  | `Process_cputime
  | `Thread_cputime
]

let clock_id_of_int v =
  Posix_time_types.clockid_of_int64
    (Int64.of_int v)

let clock_id_of_clock = function
  | `Realtime ->
      clock_id_of_int Posix_time_types.clock_realtime
  | `Monotonic ->
      clock_id_of_int Posix_time_types.clock_monotonic
  | `Process_cputime -> 
      clock_id_of_int Posix_time_types.clock_process_cputime_id
  | `Thread_cputime ->
      clock_id_of_int Posix_time_types.clock_thread_cputime_id

let to_timespec timespec =
  let get f = getf timespec f in
  { tv_sec  = PosixTypes.Time.to_int64 (get Types.Timespec.tv_sec);
    tv_nsec = Signed.Long.to_int64 (get Types.Timespec.tv_nsec) }

let from_timespec {tv_sec;tv_nsec} =
  let timespec = make Types.Timespec.t in
  setf timespec Types.Timespec.tv_sec
    (PosixTypes.Time.of_int64 tv_sec);
  setf timespec Types.Timespec.tv_nsec
    (Signed.Long.of_int64 tv_nsec);
  timespec

let asctime tm = asctime (addr (from_tm tm))

let clock_getres clock =
  Errno_unix.with_unix_exn (fun () ->
    Errno_unix.raise_on_errno (fun () ->
      let clock_id =
        clock_id_of_clock clock
      in
      let v =
        allocate_n Types.Timespec.t ~count:1
      in
      match clock_getres clock_id v with
        | 0 -> Some (to_timespec (!@ v))
        | _ -> None))

let clock_gettime clock =
  Errno_unix.with_unix_exn (fun () ->
    Errno_unix.raise_on_errno (fun () ->
      let clock_id =
        clock_id_of_clock clock
      in
      let v =
        allocate_n Types.Timespec.t ~count:1
      in
      match clock_gettime clock_id v with
        | 0 -> Some (to_timespec (!@ v))
        | _ -> None))

let clock_settime clock timespec =
  Errno_unix.with_unix_exn (fun () ->
    Errno_unix.raise_on_errno (fun () ->
      let clock_id =
        clock_id_of_clock clock
      in
      let timespec = from_timespec timespec in
      match clock_settime clock_id (addr timespec)  with
        | 0 -> Some ()
        | _ -> None))

let ctime time =
  ctime (PosixTypes.Time.of_int64 time)

let gmtime time =
  Errno_unix.with_unix_exn (fun () ->
    Errno_unix.raise_on_errno (fun () ->
      let time = PosixTypes.Time.of_int64 time in
      match gmtime time with
        | ptr when is_null ptr -> None
        | ptr -> Some (to_tm (!@ ptr))))

let localtime time =
  Errno_unix.with_unix_exn (fun () ->
    Errno_unix.raise_on_errno (fun () ->
      let time = PosixTypes.Time.of_int64 time in
      match localtime time with
        | ptr when is_null ptr -> None
        | ptr -> Some (to_tm (!@ ptr))))

let mktime tm =
  Errno_unix.with_unix_exn (fun () ->
    Errno_unix.raise_on_errno (fun () ->
      let tm = from_tm tm in 
      let time = mktime (addr tm) in
      match PosixTypes.Time.to_int64 time with
        | -1L -> None
        | time -> Some time))

let nanosleep timespec =
  Errno_unix.with_unix_exn (fun () ->
    Errno_unix.raise_on_errno (fun () ->
      let timespec = from_timespec timespec in
      match nanosleep (addr timespec) null with
        | 0 -> Some ()
        | _ -> None))
        
module Sys = struct
  type timeval = {
    tv_sec:  int64;
    tv_usec: int64
  }

  type itimerval = {
    it_interval: timeval;
    it_value: timeval
  }

  type itimer = [
    | `Real
    | `Virtual
    | `Prof
  ]

  let int_of_itimer = function
    | `Real -> Posix_time_types.itimer_real
    | `Virtual -> Posix_time_types.itimer_virtual
    | `Prof -> Posix_time_types.itimer_prof

  let to_timeval timeval =
    let get f = getf timeval f in
    { tv_sec  = PosixTypes.Time.to_int64 (get Types.Timeval.tv_sec);
      tv_usec = PosixTypes.Suseconds.to_int64 (get Types.Timeval.tv_usec) }

  let from_timeval {tv_sec;tv_usec} =
    let timeval = make Types.Timeval.t in
    setf timeval Types.Timeval.tv_sec
      (PosixTypes.Time.of_int64 tv_sec);
    setf timeval Types.Timeval.tv_usec
      (PosixTypes.Suseconds.of_int64 tv_usec);
    timeval

  let to_itimerval itimerval =
     let get f = getf itimerval f in
    { it_interval = to_timeval (get Types.Itimerval.it_interval);
      it_value = to_timeval (get Types.Itimerval.it_value) }

  let from_itimerval {it_interval;it_value} =
    let itimerval = make Types.Itimerval.t in
    setf itimerval Types.Itimerval.it_interval
      (from_timeval it_interval);
    setf itimerval Types.Itimerval.it_value
      (from_timeval it_value);
    itimerval

  let setitimer timer v =
    Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
        let v = from_itimerval v in
        let old =
          allocate_n Types.Itimerval.t ~count:1
        in
        match setitimer (int_of_itimer timer) (addr v) old with
          | x when x < 0 -> None
          | _ -> Some (to_itimerval (!@ old))))

  let getitimer timer =
    Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
        let v =
          allocate_n Types.Itimerval.t ~count:1
        in
        match getitimer (int_of_itimer timer) v  with
          | x when x < 0 -> None
          | _ -> Some (to_itimerval (!@ v))))

  let gettimeofday () =
    Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
        let timeval =
          allocate_n Types.Timeval.t ~count:1 
        in
        match gettimeofday timeval null with
          | x when x < 0 -> None
          | _ -> Some (to_timeval (!@ timeval))))

  let select r w e timeval =
    Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
        let maxfd = ref (-1) in
        let mk_fd_set l =
          let set =
            allocate_n Posix_time_types.fd_set ~count:1
          in 
          fd_zero set;
          List.iter (fun fd ->
            let fd = Obj.magic fd in
            if fd > Posix_time_types.fd_setsize then
              failwith "invalid Unix.file_descriptor!";
            if fd > !maxfd then maxfd := fd;
            fd_set fd set) l;
          set
       in
       let r_set = mk_fd_set r in
       let w_set = mk_fd_set w in
       let e_set = mk_fd_set e in
       let timeval =
         match timeval with
           | None ->
                from_voidp Types.Timeval.t null
           | Some timeval ->
                addr (from_timeval timeval)
       in
       match select (!maxfd+1) r_set w_set e_set timeval with
         | x when x < 0 -> None
         | _ ->
           let get_fd_set l fd_set =
             List.filter (fun fd ->
               fd_isset (Obj.magic fd) fd_set <> 0) l
           in
           Some ((get_fd_set r r_set,
                  get_fd_set w w_set,
                  get_fd_set e e_set))))

  let utimes path timeval =
    Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
        let timeval = from_timeval timeval in
        match utimes path (addr timeval) with
          | x when x < 0 -> None
          | _ -> Some ()))
end
