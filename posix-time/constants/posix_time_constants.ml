module Def (S : Cstubs.Types.TYPE) = struct
  let clockid_t = S.lift_typ Posix_types.clockid_t
  let clock_process_cputime_id = S.constant "CLOCK_PROCESS_CPUTIME_ID" clockid_t
  let clock_thread_cputime_id = S.constant "CLOCK_THREAD_CPUTIME_ID" clockid_t
  let clock_monotonic = S.constant "CLOCK_MONOTONIC" clockid_t
  let clock_realtime = S.constant "CLOCK_REALTIME" clockid_t
  let itimer_real = S.constant "ITIMER_REAL" S.int
  let itimer_virtual = S.constant "ITIMER_VIRTUAL" S.int
  let itimer_prof = S.constant "ITIMER_PROF" S.int
  let fd_setsize = S.constant "FD_SETSIZE" S.int
  let fd_set_size = S.constant "FD_SET_SIZE" S.int
  let fd_set_alignment = S.constant "FD_SET_ALIGNMENT" S.int
end
