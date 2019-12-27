open Ctypes

(** network/host byte order conversion functions. *)
val ntohl : Unsigned.uint32 -> Unsigned.uint32

val ntohs : Unsigned.uint16 -> Unsigned.uint16
val htonl : Unsigned.uint32 -> Unsigned.uint32
val htons : Unsigned.uint16 -> Unsigned.uint16

(** Socket types. *)
type socket_type

val socket_type_t : socket_type typ
val sock_dgram : socket_type
val sock_stream : socket_type
val sock_seqpacket : socket_type

(** Type of the [sa_family] field. *)
module Sa_family = Posix_socket_types.Sa_family

type sa_family_t = Sa_family.t

val sa_family_t : sa_family_t typ

(** Socket types constants. *)
val af_inet : sa_family_t

val af_inet6 : sa_family_t
val af_unspec : sa_family_t

(** Ctypes routines for C type socklen_t. *)
module Socklen : Unsigned.S

type socklen_t

val socklen_t : socklen_t typ

(** Storage-safe overall structure. Used to allocate
    a structure large enough for any of the sub-types
    below. *)
module SockaddrStorage : sig
  type t

  val t : t structure typ
  val ss_family : (sa_family_t, t structure) field
end

type sockaddr_storage = SockaddrStorage.t structure

val sockaddr_storage_t : sockaddr_storage typ

(** Generic sockaddr_t structure. *)
module Sockaddr : sig
  type t

  val t : t structure typ
  val sa_family : (sa_family_t, t structure) field
  val sa_data : (char carray, t structure) field
  val sa_data_len : int
  val from_sockaddr_storage : SockaddrStorage.t structure ptr -> t structure ptr
end

type sockaddr = Sockaddr.t structure

val sockaddr_t : sockaddr typ

(** Type for inet/inet6 socket port. *)
type in_port = Unsigned.uint16

val in_port_t : Unsigned.uint16 typ

(** INET (ipv4) socket_in structure. *)
module SockaddrInet : sig
  type in_addr = Unsigned.uint32

  val in_addr_t : in_addr typ
  val in_addr : in_addr structure typ
  val s_addr : (in_addr, in_addr structure) field

  type t

  val t : t structure typ
  val sin_family : (sa_family_t, t structure) field
  val sin_port : (in_port, t structure) field
  val sin_addr : (in_addr structure, t structure) field
  val from_sockaddr_storage : SockaddrStorage.t structure ptr -> t structure ptr
end

type sockaddr_in = SockaddrInet.t structure

val sockaddr_in_t : sockaddr_in typ

(** INET6 (ipv6) socket_in6 structure. *)
module SockaddrInet6 : sig
  type in6_addr

  val in6_addr : in6_addr structure typ
  val s6_addr : (in6_addr, in6_addr structure) field

  type t

  val t : t structure typ
  val sin6_family : (sa_family_t, t structure) field
  val sin6_port : (in_port, t structure) field
  val sin6_flowinfo : (Unsigned.uint32, t structure) field
  val sin6_addr : (in6_addr structure, t structure) field
  val sin6_scope_id : (Unsigned.uint32, t structure) field
  val from_sockaddr_storage : SockaddrStorage.t structure ptr -> t structure ptr
end

type sockaddr_in6 = SockaddrInet6.t structure

val sockaddr_in6_t : sockaddr_in6 typ

(** IP address conversion functions. *)
val getnameinfo : sockaddr ptr -> string * int

val getaddrinfo : string -> int -> sockaddr ptr ptr

(** Misc *)
val strnlen : char ptr -> Unsigned.size_t -> Unsigned.size_t

(** Interface with the [Unix] module. *)
val from_unix_sockaddr : Unix.sockaddr -> sockaddr ptr

val to_unix_sockaddr : sockaddr ptr -> Unix.sockaddr
