open Posix_time2

let sprint_timespec { Timespec.tv_sec; tv_nsec } =
  Printf.sprintf "tv_sec: %Li, tv_nsec: %Li" tv_sec tv_nsec

let sprint_timeval { Timeval.tv_sec; tv_usec } =
  Printf.sprintf "tv_sec: %Li, tv_usec: %Li" tv_sec tv_usec

let sprint_itimerval { Itimerval.it_interval; it_value } =
  Printf.sprintf "it_interval: { %s } , it_value = { %s }"
    (sprint_timeval it_interval)
    (sprint_timeval it_value)

let timer1 =
  {
    Itimerval.it_interval = Timeval.create 1982L 0L;
    it_value = Timeval.create 0L 0L;
  }

let timer2 =
  {
    Itimerval.it_interval = Timeval.create 0L 0L;
    it_value = Timeval.create 2020L 0L;
  }

let () =
  let timer = setitimer `Real timer1 in
  Printf.printf "setitimer: %s\n%!" (sprint_itimerval timer);

  let timer = getitimer `Real in
  Printf.printf "getitimer: %s\n%!" (sprint_itimerval timer);

  let timer = setitimer `Real timer2 in
  Printf.printf "setitimer: %s\n%!" (sprint_itimerval timer);

  let timer = setitimer `Real timer1 in
  Printf.printf "setitimer: %s\n%!" (sprint_itimerval timer);

  Printf.printf "gettimeofday: %s\n%!" (sprint_timeval (gettimeofday ()));

  Printf.printf "Sleeping 1s..\n%!";
  nanosleep (Timespec.create 1L 0L);

  let r, w = Unix.pipe () in
  let th =
    Thread.create
      (fun () ->
        match select [r] [] [] None with
          | [x], [], [] when x = r ->
              Printf.printf "Done waiting on read socket!\n%!"
          | _ -> assert false)
      ()
  in
  ignore (Unix.write w (Bytes.of_string " ") 0 1);
  Thread.join th;

  let timespec = clock_getres `Monotonic in
  Printf.printf "Monotonic time clock resolution: %s\n%!"
    (sprint_timespec timespec);

  let timespec = clock_gettime `Monotonic in
  Printf.printf "Monotonic time time: %s\n%!" (sprint_timespec timespec);

  let timespec = clock_getres `Process_cputime in
  Printf.printf "Process clock resolution: %s\n%!" (sprint_timespec timespec);

  let timespec = clock_gettime `Process_cputime in
  Printf.printf "Process time: %s\n%!" (sprint_timespec timespec)
