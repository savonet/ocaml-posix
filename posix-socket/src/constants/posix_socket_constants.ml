module Def (S : Cstubs.Types.TYPE) = struct
  include Posix_eai_errno_constants.Def (S)

  let af_inet = S.constant "AF_INET" S.int
  let af_inet6 = S.constant "AF_INET6" S.int
  let af_unix = S.constant "AF_UNIX" S.int
  let af_unspec = S.constant "AF_UNSPEC" S.int
  let sa_family_t_len = S.constant "SA_FAMILY_T_LEN" S.int
  let sockaddr_storage_len = S.constant "SOCKADDR_STORAGE_LEN" S.int
  let sock_dgram = S.constant "SOCK_DGRAM" S.int
  let sock_stream = S.constant "SOCK_STREAM" S.int
  let sock_seqpacket = S.constant "SOCK_STREAM" S.int
  let socklen_t_len = S.constant "SOCKLEN_T_LEN" S.int
  let ni_maxserv = S.constant "NI_MAXSERV" S.int
  let ni_maxhost = S.constant "NI_MAXHOST" S.int
  let ni_numerichost = S.constant "NI_NUMERICHOST" S.int
  let ni_numericserv = S.constant "NI_NUMERICSERV" S.int
  let ipproto_ip = S.constant "IPPROTO_IP" S.int
  let ipproto_ipv6 = S.constant "IPPROTO_IPV6" S.int
  let ipproto_icmp = S.constant "IPPROTO_ICMP" S.int
  let ipproto_raw = S.constant "IPPROTO_RAW" S.int
  let ipproto_tcp = S.constant "IPPROTO_TCP" S.int
  let ipproto_udp = S.constant "IPPROTO_UDP" S.int
end
