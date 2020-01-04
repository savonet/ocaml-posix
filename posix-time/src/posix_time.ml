open Ctypes
include Posix_time_stubs.Def (Posix_time_generated_stubs)

module Timespec = struct
  type t = { tv_sec : int64; tv_nsec : int64 }

  let to_timespec timespec =
    let get f = getf timespec f in
    {
      tv_sec = Posix_types.Time.to_int64 (get Types.Timespec.tv_sec);
      tv_nsec = Signed.Long.to_int64 (get Types.Timespec.tv_nsec);
    }

  let from_timespec { tv_sec; tv_nsec } =
    let timespec = make Types.Timespec.t in
    setf timespec Types.Timespec.tv_sec (Posix_types.Time.of_int64 tv_sec);
    setf timespec Types.Timespec.tv_nsec (Signed.Long.of_int64 tv_nsec);
    timespec

  let max_nsec = 1000000000L

  let compare x y =
    match Int64.compare x.tv_sec y.tv_sec with
      | 0 -> Int64.compare x.tv_nsec y.tv_nsec
      | d -> d

  let create sec nsec =
    let rec normalize sec nsec =
      if nsec < Int64.zero then
        normalize (Int64.pred sec) (Int64.add nsec max_nsec)
      else if nsec >= max_nsec then
        normalize (Int64.succ sec) (Int64.sub nsec max_nsec)
      else (sec, nsec)
    in
    let tv_sec, tv_nsec = normalize sec nsec in
    { tv_sec; tv_nsec }

  let add x y =
    create Int64.(add x.tv_sec y.tv_sec) Int64.(add x.tv_nsec y.tv_nsec)

  let sub x y =
    create Int64.(sub x.tv_sec y.tv_sec) Int64.(sub x.tv_nsec y.tv_nsec)

  let add_sec sec t = { t with tv_sec = Int64.add t.tv_sec sec }
  let sub_sec sec t = { t with tv_sec = Int64.sub t.tv_sec sec }
  let add_nsec nsec t = create t.tv_sec (Int64.add t.tv_nsec nsec)
  let sub_nsec nsec t = create t.tv_sec (Int64.sub t.tv_nsec nsec)
  let to_string t = Printf.sprintf "%Ld.%09Ld" t.tv_sec t.tv_nsec
end

module Timeval = struct
  type t = { tv_sec : int64; tv_usec : int64 }

  let to_timeval timeval =
    let get f = getf timeval f in
    {
      tv_sec = Posix_types.Time.to_int64 (get Types.Timeval.tv_sec);
      tv_usec = Posix_types.Suseconds.to_int64 (get Types.Timeval.tv_usec);
    }

  let from_timeval { tv_sec; tv_usec } =
    let timeval = make Types.Timeval.t in
    setf timeval Types.Timeval.tv_sec (Posix_types.Time.of_int64 tv_sec);
    setf timeval Types.Timeval.tv_usec (Posix_types.Suseconds.of_int64 tv_usec);
    timeval

  let max_usec = 1000000L

  let compare x y =
    match Int64.compare x.tv_sec y.tv_sec with
      | 0 -> Int64.compare x.tv_usec y.tv_usec
      | d -> d

  let create sec usec =
    let rec normalize sec usec =
      if usec < Int64.zero then
        normalize (Int64.pred sec) (Int64.add usec max_usec)
      else if usec >= max_usec then
        normalize (Int64.succ sec) (Int64.sub usec max_usec)
      else (sec, usec)
    in
    let tv_sec, tv_usec = normalize sec usec in
    { tv_sec; tv_usec }

  let add x y =
    create Int64.(add x.tv_sec y.tv_sec) Int64.(add x.tv_usec y.tv_usec)

  let sub x y =
    create Int64.(sub x.tv_sec y.tv_sec) Int64.(sub x.tv_usec y.tv_usec)

  let add_sec sec t = { t with tv_sec = Int64.add t.tv_sec sec }
  let sub_sec sec t = { t with tv_sec = Int64.sub t.tv_sec sec }
  let add_usec usec t = create t.tv_sec (Int64.add t.tv_usec usec)
  let sub_usec usec t = create t.tv_sec (Int64.sub t.tv_usec usec)
  let to_string t = Printf.sprintf "%Ld.%06Ld" t.tv_sec t.tv_usec
end

module Tm = struct
  type t = {
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

  let to_tm tm =
    let get f = getf tm f in
    {
      tm_sec = get Types.Tm.tm_sec;
      tm_min = get Types.Tm.tm_min;
      tm_hour = get Types.Tm.tm_hour;
      tm_mday = get Types.Tm.tm_mday;
      tm_mon = get Types.Tm.tm_mon;
      tm_year = get Types.Tm.tm_year;
      tm_wday = get Types.Tm.tm_wday;
      tm_yday = get Types.Tm.tm_yday;
      tm_isdst = get Types.Tm.tm_isdst;
    }

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
    setf _tm Types.Tm.tm_isdst tm.tm_isdst;
    _tm

  let create tm_sec tm_min tm_hour tm_mday tm_mon tm_year tm_wday tm_yday
      tm_isdst =
    let in_range a b x = a <= x && x <= b in
    if
      in_range 0 61 tm_sec && in_range 0 59 tm_min && in_range 0 23 tm_hour
      && in_range 0 31 tm_mday && in_range 0 11 tm_mon && in_range 0 6 tm_wday
      && in_range 0 365 tm_yday
    then
      Some
        {
          tm_sec;
          tm_min;
          tm_hour;
          tm_mday;
          tm_mon;
          tm_year;
          tm_wday;
          tm_yday;
          tm_isdst;
        }
    else None

  let compare x y =
    match compare x.tm_year y.tm_year with
      | 0 -> (
          match compare x.tm_mon y.tm_mon with
            | 0 -> (
                match compare x.tm_mday y.tm_mday with
                  | 0 -> (
                      match compare x.tm_hour y.tm_hour with
                        | 0 -> (
                            match compare x.tm_min y.tm_min with
                              | 0 -> compare x.tm_sec y.tm_sec
                              | d -> d )
                        | d -> d )
                  | d -> d )
            | d -> d )
      | d -> d
end

module Itimerval = struct
  type t = { it_interval : Timeval.t; it_value : Timeval.t }

  let to_itimerval itimerval =
    let get f = getf itimerval f in
    {
      it_interval = Timeval.to_timeval (get Types.Itimerval.it_interval);
      it_value = Timeval.to_timeval (get Types.Itimerval.it_value);
    }

  let from_itimerval { it_interval; it_value } =
    let itimerval = make Types.Itimerval.t in
    setf itimerval Types.Itimerval.it_interval
      (Timeval.from_timeval it_interval);
    setf itimerval Types.Itimerval.it_value (Timeval.from_timeval it_value);
    itimerval
end

module Itimerspec = struct
  type t = { it_interval : Timespec.t; it_value : Timespec.t }
end

type clock = [ `Realtime | `Monotonic | `Process_cputime | `Thread_cputime ]

let clock_id_of_clock = function
  | `Realtime -> Posix_time_types.clock_realtime
  | `Monotonic -> Posix_time_types.clock_monotonic
  | `Process_cputime -> Posix_time_types.clock_process_cputime_id
  | `Thread_cputime -> Posix_time_types.clock_thread_cputime_id

let asctime tm = asctime (addr (Tm.from_tm tm))

let clock_getres clock =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          let clock_id = clock_id_of_clock clock in
          let v = allocate_n Types.Timespec.t ~count:1 in
          match clock_getres clock_id v with
            | 0 -> Some (Timespec.to_timespec !@v)
            | _ -> None))

let clock_gettime clock =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          let clock_id = clock_id_of_clock clock in
          let v = allocate_n Types.Timespec.t ~count:1 in
          match clock_gettime clock_id v with
            | 0 -> Some (Timespec.to_timespec !@v)
            | _ -> None))

let clock_settime clock timespec =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          let clock_id = clock_id_of_clock clock in
          let timespec = Timespec.from_timespec timespec in
          match clock_settime clock_id (addr timespec) with
            | 0 -> Some ()
            | _ -> None))

let ctime time = ctime (Posix_types.Time.of_int64 time)

let gmtime time =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          let time = Posix_types.Time.of_int64 time in
          match gmtime time with
            | ptr when is_null ptr -> None
            | ptr -> Some (Tm.to_tm !@ptr)))

let localtime time =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          let time = Posix_types.Time.of_int64 time in
          match localtime time with
            | ptr when is_null ptr -> None
            | ptr -> Some (Tm.to_tm !@ptr)))

let mktime tm =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          let tm = Tm.from_tm tm in
          let time = mktime (addr tm) in
          match Posix_types.Time.to_int64 time with
            | -1L -> None
            | time -> Some time))

let nanosleep timespec =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          let timespec = Timespec.from_timespec timespec in
          match nanosleep (addr timespec) null with 0 -> Some () | _ -> None))

type itimer = [ `Real | `Virtual | `Prof ]

let int_of_itimer = function
  | `Real -> Posix_time_types.itimer_real
  | `Virtual -> Posix_time_types.itimer_virtual
  | `Prof -> Posix_time_types.itimer_prof

let setitimer timer v =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          let v = Itimerval.from_itimerval v in
          let old = allocate_n Types.Itimerval.t ~count:1 in
          match setitimer (int_of_itimer timer) (addr v) old with
            | x when x < 0 -> None
            | _ -> Some (Itimerval.to_itimerval !@old)))

let getitimer timer =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          let v = allocate_n Types.Itimerval.t ~count:1 in
          match getitimer (int_of_itimer timer) v with
            | x when x < 0 -> None
            | _ -> Some (Itimerval.to_itimerval !@v)))

let gettimeofday () =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          let timeval = allocate_n Types.Timeval.t ~count:1 in
          match gettimeofday timeval null with
            | x when x < 0 -> None
            | _ -> Some (Timeval.to_timeval !@timeval)))

let select r w e timeval =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          let maxfd = ref (-1) in
          let mk_fd_set l =
            let set = allocate_n Posix_time_types.fd_set ~count:1 in
            fd_zero set;
            List.iter
              (fun fd ->
                let fd = Obj.magic fd in
                if fd > Posix_time_types.fd_setsize then
                  failwith "invalid Unix.file_descriptor!";
                if fd > !maxfd then maxfd := fd;
                fd_set fd set)
              l;
            set
          in
          let r_set = mk_fd_set r in
          let w_set = mk_fd_set w in
          let e_set = mk_fd_set e in
          let timeval =
            match timeval with
              | None -> from_voidp Types.Timeval.t null
              | Some timeval -> addr (Timeval.from_timeval timeval)
          in
          match select (!maxfd + 1) r_set w_set e_set timeval with
            | x when x < 0 -> None
            | _ ->
                let get_fd_set l fd_set =
                  List.filter (fun fd -> fd_isset (Obj.magic fd) fd_set <> 0) l
                in
                Some (get_fd_set r r_set, get_fd_set w w_set, get_fd_set e e_set)))

let utimes path timeval =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          let timeval = Timeval.from_timeval timeval in
          match utimes path (addr timeval) with
            | x when x < 0 -> None
            | _ -> Some ()))
