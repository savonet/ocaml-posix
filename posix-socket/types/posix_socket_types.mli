open Ctypes

module SaFamily : sig
  type sa_family
  val int_of_sa_family : sa_family -> int
  val sa_family_of_int : int -> sa_family

  module T : functor (S : Cstubs.Types.TYPE) -> sig
    val t : sa_family S.typ
  end
end

module Def (S : Cstubs.Types.TYPE) : sig 
  val sa_family_t : SaFamily.sa_family S.typ

  val af_inet      : SaFamily.sa_family
  val af_inet6     : SaFamily.sa_family
  val af_unspec    : SaFamily.sa_family
  val sa_data_len  : int
  val sock_dgram   : int
  val sock_stream  : int
  val sock_seqpacket : int
  val ni_maxserv   : int
  val ni_maxhost   : int
  val ni_numerichost : int
  val ni_numericserv : int

  type socklen
  val socklen_t : socklen S.typ
  val int_of_socklen : socklen -> int
  val socklen_of_int : int -> socklen
  
  module Sockaddr : sig
    type t
    val t : t structure S.typ
    val sa_family : (SaFamily.sa_family, t structure) S.field
    val sa_data : (char carray, t structure) S.field
  end

  type sockaddr = Sockaddr.t structure
  val sockaddr_t : sockaddr S.typ

  module Addrinfo : sig
    type t
    val t : t structure S.typ
    val ai_flags : (int, t structure) S.field
    val ai_addrlen : (socklen, t structure) S.field
    val ai_addr : (sockaddr ptr, t structure) S.field
  end

  module Servent : sig
    type t
    val t : t structure S.typ
    val s_port : (Unsigned.uint16, t structure) S.field
  end

  module SockaddrStorage : sig
    type t
    val t : t structure S.typ
    val ss_family : (SaFamily.sa_family, t structure) S.field
  end

  type sockaddr_storage = SockaddrStorage.t structure
  val sockaddr_storage_t : sockaddr_storage S.typ

  type in_port = Unsigned.uint16
  val in_port_t : Unsigned.uint16 S.typ
  
  module SockaddrInet : sig
    type in_addr = Unsigned.uint32
    val in_addr_t : Unsigned.uint32 S.typ
  
    val in_addr : in_addr structure S.typ
    val s_addr : (in_addr, in_addr structure) S.field
  
    type t

    val t : t structure S.typ
    val sin_family : (SaFamily.sa_family, t structure) S.field
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
    val sin6_family : (SaFamily.sa_family, t structure) S.field
    val sin6_port : (in_port, t structure) S.field
    val sin6_flowinfo : (Unsigned.uint32, t structure) S.field
    val sin6_addr : (in6_addr structure, t structure) S.field
    val sin6_scope_id : (Unsigned.uint32, t structure) S.field
  end

  type sockaddr_in6 = SockaddrInet6.t structure
  val sockaddr_in6_t : sockaddr_in6 S.typ
end
