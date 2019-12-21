open Posix_time

let sprint_timespec {tv_sec; tv_nsec} =
  Printf.sprintf "tv_sec: %Li, tv_nsec: %Li" tv_sec tv_nsec

let sprint_timeval {Sys.tv_sec; tv_usec} =
  Printf.sprintf "tv_sec: %Li, tv_usec: %Li" tv_sec tv_usec

let sprint_itimerval {Sys.it_interval;it_value} =
  Printf.sprintf "it_interval: { %s } , it_value = { %s }" 
    (sprint_timeval it_interval) (sprint_timeval it_value)

let timer1 = {Sys.
  it_interval = {
    tv_sec = 1982L;
    tv_usec = 0L
  };
  it_value = {
    tv_sec = 0L;
    tv_usec = 0L
  }
}

let timer2 = {Sys.
  it_interval = {
    tv_sec = 0L;
    tv_usec = 0L
  };
  it_value = {
    tv_sec = 2020L;
    tv_usec = 0L
  }
}

let () =
  let timer = Sys.setitimer `Real timer1 in
  Printf.printf "setitimer: %s\n%!"
    (sprint_itimerval timer);

  let timer = Sys.getitimer `Real in
  Printf.printf "getitimer: %s\n%!"
    (sprint_itimerval timer);

  let timer = Sys.setitimer `Real timer2 in
  Printf.printf "setitimer: %s\n%!"
    (sprint_itimerval timer);

  let timer = Sys.setitimer `Real timer1 in
  Printf.printf "setitimer: %s\n%!"
    (sprint_itimerval timer);

  Printf.printf "gettimeofday: %s\n%!"
    (sprint_timeval (Sys.gettimeofday ()));

  Printf.printf "Sleeping 10s..\n%!";
  nanosleep {tv_sec=1L;tv_nsec=0L};

  let (r, w) = Unix.pipe () in
  let th = Thread.create (fun () ->
    match Sys.select [r] [] [] None with
      | [x], [], [] when x = r ->
          Printf.printf "Done waiting on read socket!\n%!"
      | _ -> assert false) ()
  in
  ignore(Unix.write w (Bytes.of_string " ") 0 1);
  Thread.join th;
   
  let timespec = clock_getres `Monotonic in
  Printf.printf "Monotonic time clock resolution: %s\n%!"
    (sprint_timespec timespec);

  let timespec = clock_gettime `Monotonic in
  Printf.printf "Monotonic time time: %s\n%!"
    (sprint_timespec timespec);

  let timespec = clock_getres `Process_cputime in
  Printf.printf "Process clock resolution: %s\n%!"
    (sprint_timespec timespec);

  let timespec = clock_gettime `Process_cputime in
  Printf.printf "Process time: %s\n%!"
    (sprint_timespec timespec);
