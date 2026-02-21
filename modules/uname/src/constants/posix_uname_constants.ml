module Def (S : Cstubs.Types.TYPE) = struct
  let sysname_len = S.constant "SYSNAME_LEN" S.int
  let nodename_len = S.constant "NODENAME_LEN" S.int
  let release_len = S.constant "RELEASE_LEN" S.int
  let version_len = S.constant "VERSION_LEN" S.int
  let machine_len = S.constant "MACHINE_LEN" S.int
end
