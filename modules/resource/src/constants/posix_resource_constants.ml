module Def (S : Cstubs.Types.TYPE) = struct
  (* Resource limit types *)
  let rlimit_cpu = S.constant "RLIMIT_CPU" S.int
  let rlimit_fsize = S.constant "RLIMIT_FSIZE" S.int
  let rlimit_data = S.constant "RLIMIT_DATA" S.int
  let rlimit_stack = S.constant "RLIMIT_STACK" S.int
  let rlimit_core = S.constant "RLIMIT_CORE" S.int
  let rlimit_nofile = S.constant "RLIMIT_NOFILE" S.int
  let rlimit_as = S.constant "RLIMIT_AS" S.int

  (* rusage who constants *)
  let rusage_self = S.constant "RUSAGE_SELF" S.int
  let rusage_children = S.constant "RUSAGE_CHILDREN" S.int

  (* Priority who constants *)
  let prio_process = S.constant "PRIO_PROCESS" S.int
  let prio_pgrp = S.constant "PRIO_PGRP" S.int
  let prio_user = S.constant "PRIO_USER" S.int

  (* Special rlimit value - needs special handling *)
  let rlim_infinity = S.constant "RLIM_INFINITY" S.uint64_t
end
