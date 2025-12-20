open Ctypes
module Sa_family : Unsigned.S

type sa_family_t = Sa_family.t

val sockaddr_storage_len : int

val sa_family_t : sa_family_t typ
val af_inet : sa_family_t
val af_inet6 : sa_family_t
val af_unspec : sa_family_t
val sock_stream : int
val sock_dgram : int
val sock_seqpacket : int
val ni_maxserv : int
val ni_maxhost : int
val ni_numerichost : int
val ni_numericserv : int
val ipproto_ip : int
val ipproto_ipv6 : int
val ipproto_icmp : int
val ipproto_raw : int
val ipproto_tcp : int
val ipproto_udp : int

module Socklen : Unsigned.S

type socklen_t = Socklen.t

val socklen_t : socklen_t typ

module Def (S : Cstubs.Types.TYPE) : sig
  module Sockaddr : sig
    type t

    val t : t structure S.typ
    val sa_family : (sa_family_t, t structure) S.field
  end

  type sockaddr = Sockaddr.t structure

  val sockaddr_t : sockaddr S.typ

  module Addrinfo : sig
    type t

    val t : t structure S.typ
    val ai_flags : (int, t structure) S.field
    val ai_family : (sa_family_t, t structure) S.field
    val ai_socktype : (int, t structure) S.field
    val ai_protocol : (int, t structure) S.field
    val ai_addrlen : (socklen_t, t structure) S.field
    val ai_addr : (sockaddr ptr, t structure) S.field
    val ai_next : (t structure ptr, t structure) S.field
  end

  module Servent : sig
    type t

    val t : t structure S.typ
    val s_port : (Unsigned.uint16, t structure) S.field
  end

  type in_port = Unsigned.uint16

  val in_port_t : Unsigned.uint16 S.typ

  module SockaddrInet : sig
    type in_addr = Unsigned.uint32

    val in_addr_t : Unsigned.uint32 S.typ
    val in_addr : in_addr structure S.typ
    val s_addr : (in_addr, in_addr structure) S.field

    type t

    val t : t structure S.typ
    val sin_family : (sa_family_t, t structure) S.field
    val sin_port : (in_port, t structure) S.field
    val sin_addr : (in_addr structure, t structure) S.field
  end

  type sockaddr_in = SockaddrInet.t structure

  val sockaddr_in_t : sockaddr_in S.typ

  module SockaddrInet6 : sig
    type in6_addr = Unsigned.uint8 carray

    val in6_addr : in6_addr structure S.typ
    val s6_addr : (in6_addr, in6_addr structure) S.field

    type t

    val t : t structure S.typ
    val sin6_family : (sa_family_t, t structure) S.field
    val sin6_port : (in_port, t structure) S.field
    val sin6_flowinfo : (Unsigned.uint32, t structure) S.field
    val sin6_addr : (in6_addr structure, t structure) S.field
    val sin6_scope_id : (Unsigned.uint32, t structure) S.field
  end

  type sockaddr_in6 = SockaddrInet6.t structure

  val sockaddr_in6_t : sockaddr_in6 S.typ
end
