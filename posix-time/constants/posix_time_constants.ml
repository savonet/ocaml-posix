module Def (S : Cstubs.Types.TYPE) = struct
  let clock_process_cputime_id = S.constant "CLOCK_PROCESS_CPUTIME_ID" S.int
  let clock_thread_cputime_id = S.constant "CLOCK_THREAD_CPUTIME_ID" S.int
  let clock_monotonic = S.constant "CLOCK_MONOTONIC" S.int
  let clock_realtime = S.constant "CLOCK_REALTIME" S.int
  let clockid_len = S.constant "CLOCKID_T_LEN" S.int

  let itimer_real = S.constant "ITIMER_REAL" S.int
  let itimer_virtual = S.constant "ITIMER_VIRTUAL" S.int
  let itimer_prof = S.constant "ITIMER_PROF" S.int
  let fd_setsize = S.constant "FD_SETSIZE" S.int
  let fd_set_size = S.constant "FD_SET_SIZE" S.int
  let fd_set_alignment = S.constant "FD_SET_ALIGNMENT" S.int
end
