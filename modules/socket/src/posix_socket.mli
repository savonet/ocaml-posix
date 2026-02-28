(** POSIX socket interface bindings.

    This module provides OCaml bindings to the POSIX socket API defined in
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_socket.h.html}
     sys/socket.h} and
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/netdb.h.html}
     netdb.h}.

    It includes functions for address resolution, byte order conversion, and
    socket address manipulation. *)

open Ctypes

(** {1 Error Handling}

    Error codes returned by address resolution functions like
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getaddrinfo.html}
     getaddrinfo} and
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getnameinfo.html}
     getnameinfo}. *)

(** Address resolution error codes (EAI_* constants). *)
type error =
  [ `ADDRFAMILY  (** Address family not supported *)
  | `AGAIN  (** Temporary failure in name resolution *)
  | `BADFLAGS  (** Invalid flags value *)
  | `BADHINTS  (** Invalid hints value *)
  | `FAIL  (** Non-recoverable failure in name resolution *)
  | `FAMILY  (** Address family not supported *)
  | `MEMORY  (** Memory allocation failure *)
  | `NODATA  (** No address associated with hostname *)
  | `NONAME  (** Name or service not known *)
  | `PROTOCOL  (** Resolved protocol is unknown *)
  | `SOCKTYPE  (** Socket type not supported *)
  | `OVERFLOW  (** Argument buffer overflow *)
  | `SERVICE  (** Service not supported for socket type *)
  | `SYSTEM  (** System error, check errno *)
  | `UNKNOWN of int  (** Unknown error code *) ]

(** Convert an error to its integer representation. *)
val int_of_error : error -> int

(** Convert an integer to an error code. *)
val error_of_int : int -> error

(** Returns [true] if this error code is natively defined on this platform. *)
val is_native : error -> bool

(** Return a human-readable error message. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/gai_strerror.html}
     gai_strerror(3)}. *)
val strerror : error -> string

(** Exception raised by address resolution functions on error. *)
exception Error of error

(** {1 Byte Order Conversion}

    Functions for converting between network byte order (big-endian) and host
    byte order. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/htonl.html}
     byteorder(3)}. *)

(** Convert 32-bit integer from network to host byte order. *)
val ntohl : Unsigned.uint32 -> Unsigned.uint32

(** Convert 16-bit integer from network to host byte order. *)
val ntohs : Unsigned.uint16 -> Unsigned.uint16

(** Convert 32-bit integer from host to network byte order. *)
val htonl : Unsigned.uint32 -> Unsigned.uint32

(** Convert 16-bit integer from host to network byte order. *)
val htons : Unsigned.uint16 -> Unsigned.uint16

(** {1 Socket Types}

    Socket type constants used when creating sockets. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/socket.html}
     socket(2)}. *)

(** Abstract type representing socket types. *)
type socket_type

(** Ctypes representation of socket_type. *)
val socket_type_t : socket_type typ

(** Datagram socket (connectionless, unreliable). Used with UDP. *)
val sock_dgram : socket_type

(** Stream socket (connection-oriented, reliable). Used with TCP. *)
val sock_stream : socket_type

(** Sequenced packet socket (connection-oriented, reliable, message boundaries
    preserved). *)
val sock_seqpacket : socket_type

(** {1 Address Families}

    Socket address family constants. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_socket.h.html}
     sys/socket.h}. *)

(** Module for the [sa_family] field type. *)
module Sa_family = Posix_socket_types.Sa_family

(** Type alias for address family. *)
type sa_family_t = Sa_family.t

(** Ctypes representation of sa_family_t. *)
val sa_family_t : sa_family_t typ

(** IPv4 address family (AF_INET). *)
val af_inet : sa_family_t

(** IPv6 address family (AF_INET6). *)
val af_inet6 : sa_family_t

(** Unspecified address family (AF_UNSPEC). Used to request any address family.
*)
val af_unspec : sa_family_t

(** {1 Name Resolution Constants}

    Constants for
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getnameinfo.html}
     getnameinfo(3)}. *)

(** Maximum length of a service name string. *)
val ni_maxserv : int

(** Maximum length of a host name string. *)
val ni_maxhost : int

(** Return numeric form of the host address. *)
val ni_numerichost : int

(** Return numeric form of the service (port number). *)
val ni_numericserv : int

(** {1 Protocol Constants}

    IP protocol numbers for use with sockets. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/netinet_in.h.html}
     netinet/in.h}. *)

(** Internet Protocol (IP). *)
val ipproto_ip : int

(** Internet Protocol version 6 (IPv6). *)
val ipproto_ipv6 : int

(** Internet Control Message Protocol (ICMP). *)
val ipproto_icmp : int

(** Raw IP packets. *)
val ipproto_raw : int

(** Transmission Control Protocol (TCP). *)
val ipproto_tcp : int

(** User Datagram Protocol (UDP). *)
val ipproto_udp : int

(** {1 Socket Length Type}

    The [socklen_t] type used for socket address lengths. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_socket.h.html}
     sys/socket.h}. *)

(** Unsigned module for socklen_t arithmetic. *)
module Socklen : Unsigned.S

(** Abstract socklen_t type. *)
type socklen_t

(** Ctypes representation of socklen_t. *)
val socklen_t : socklen_t typ

(** {1 Socket Address Storage}

    Generic socket address storage large enough to hold any socket address type.
    See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_socket.h.html}
     sockaddr_storage}. *)

(** Abstract type for socket address storage. *)
type sockaddr_storage

(** Allocate a new socket address storage structure. *)
val sockaddr_storage : unit -> sockaddr_storage ptr

(** Size of sockaddr_storage in bytes. *)
val sockaddr_storage_len : int

(** {1 Generic Socket Address}

    The generic [sockaddr] structure. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_socket.h.html}
     sockaddr}. *)

(** Generic socket address structure. *)
module Sockaddr : sig
  (** Abstract sockaddr type. *)
  type t

  (** Ctypes structure type. *)
  val t : t structure typ

  (** Address family field. *)
  val sa_family : (sa_family_t, t structure) field

  (** Convert from sockaddr_storage to sockaddr. *)
  val from_sockaddr_storage : sockaddr_storage ptr -> t structure ptr
end

(** Type alias for sockaddr structure. *)
type sockaddr = Sockaddr.t structure

(** Ctypes representation of sockaddr. *)
val sockaddr_t : sockaddr typ

(** Return the actual length of a socket address based on its family. *)
val sockaddr_len : sockaddr ptr -> int

(** {1 Address Info}

    The [addrinfo] structure used by getaddrinfo. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getaddrinfo.html}
     getaddrinfo(3)}. *)

(** Address information structure returned by [getaddrinfo]. *)
module Addrinfo : sig
  (** Abstract addrinfo type. *)
  type t

  (** Ctypes structure type. *)
  val t : t structure typ

  (** Input flags (AI_* constants). *)
  val ai_flags : (int, t structure) field

  (** Address family (AF_* constants). *)
  val ai_family : (int, t structure) field

  (** Socket type (SOCK_* constants). *)
  val ai_socktype : (socket_type, t structure) field

  (** Protocol (IPPROTO_* constants). *)
  val ai_protocol : (int, t structure) field

  (** Length of socket address. *)
  val ai_addrlen : (socklen_t, t structure) field

  (** Socket address. *)
  val ai_addr : (sockaddr ptr, t structure) field

  (** Next addrinfo in linked list. *)
  val ai_next : (t structure ptr, t structure) field
end

(** {1 Port Type} *)

(** Port number type (16-bit unsigned integer in network byte order). *)
type in_port = Unsigned.uint16

(** Ctypes representation of in_port_t. *)
val in_port_t : Unsigned.uint16 typ

(** {1 IPv4 Socket Address}

    The [sockaddr_in] structure for IPv4 addresses. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/netinet_in.h.html}
     netinet/in.h}. *)

(** IPv4 socket address structure. *)
module SockaddrInet : sig
  (** IPv4 address type (32-bit). *)
  type in_addr = Unsigned.uint32

  (** Ctypes representation of in_addr_t. *)
  val in_addr_t : in_addr typ

  (** Ctypes representation of struct in_addr. *)
  val in_addr : in_addr structure typ

  (** The s_addr field containing the IPv4 address. *)
  val s_addr : (in_addr, in_addr structure) field

  (** Abstract sockaddr_in type. *)
  type t

  (** Ctypes structure type. *)
  val t : t structure typ

  (** Address family (always AF_INET). *)
  val sin_family : (sa_family_t, t structure) field

  (** Port number in network byte order. *)
  val sin_port : (in_port, t structure) field

  (** IPv4 address. *)
  val sin_addr : (in_addr structure, t structure) field

  (** Convert from sockaddr_storage to sockaddr_in. *)
  val from_sockaddr_storage : sockaddr_storage ptr -> t structure ptr
end

(** Type alias for IPv4 socket address. *)
type sockaddr_in = SockaddrInet.t structure

(** Ctypes representation of sockaddr_in. *)
val sockaddr_in_t : sockaddr_in typ

(** {1 IPv6 Socket Address}

    The [sockaddr_in6] structure for IPv6 addresses. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/netinet_in.h.html}
     netinet/in.h}. *)

(** IPv6 socket address structure. *)
module SockaddrInet6 : sig
  (** IPv6 address type (128-bit). *)
  type in6_addr

  (** Ctypes representation of struct in6_addr. *)
  val in6_addr : in6_addr structure typ

  (** The s6_addr field containing the IPv6 address bytes. *)
  val s6_addr : (in6_addr, in6_addr structure) field

  (** Abstract sockaddr_in6 type. *)
  type t

  (** Ctypes structure type. *)
  val t : t structure typ

  (** Address family (always AF_INET6). *)
  val sin6_family : (sa_family_t, t structure) field

  (** Port number in network byte order. *)
  val sin6_port : (in_port, t structure) field

  (** IPv6 flow information. *)
  val sin6_flowinfo : (Unsigned.uint32, t structure) field

  (** IPv6 address. *)
  val sin6_addr : (in6_addr structure, t structure) field

  (** Scope ID for link-local addresses. *)
  val sin6_scope_id : (Unsigned.uint32, t structure) field

  (** Convert from sockaddr_storage to sockaddr_in6. *)
  val from_sockaddr_storage : sockaddr_storage ptr -> t structure ptr
end

(** Type alias for IPv6 socket address. *)
type sockaddr_in6 = SockaddrInet6.t structure

(** Ctypes representation of sockaddr_in6. *)
val sockaddr_in6_t : sockaddr_in6 typ

(** {1 Address Resolution Functions} *)

(** Convert a socket address to a hostname and port number.

    This is a wrapper around
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getnameinfo.html}
     getnameinfo(3)}.

    @param sockaddr The socket address to convert.
    @return A tuple [(hostname, port)].
    @raise Error if the conversion fails. *)
val getnameinfo : sockaddr ptr -> string * int

(** Resolve a hostname to a list of socket addresses.

    This is a wrapper around
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getaddrinfo.html}
     getaddrinfo(3)}.

    @param hints Optional hints to filter results.
    @param port Optional port number or service name.
    @param hostname The hostname to resolve.
    @return A list of socket addresses.
    @raise Error if resolution fails.

    Example:
    {[
      let addresses = getaddrinfo ~port:(`Int 443) "example.com" in
      List.iter
        (fun addr ->
          let host, port = getnameinfo addr in
          Printf.printf "%s:%d\n" host port)
        addresses
    ]} *)
val getaddrinfo :
  ?hints:Addrinfo.t structure ptr ->
  ?port:[ `Int of int | `String of string ] ->
  string ->
  sockaddr ptr list

(** {1 Utility Functions} *)

(** Calculate the length of a null-terminated string up to a maximum. See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/strnlen.html}
     strnlen(3)}. *)
val strnlen : char ptr -> Unsigned.size_t -> Unsigned.size_t

(** {1 Unix Module Interoperability}

    Functions for converting between [Unix.sockaddr] and POSIX socket addresses.
*)

(** Convert a [Unix.sockaddr] to a POSIX socket address.

    @param addr The Unix socket address to convert.
    @return A pointer to the equivalent POSIX sockaddr. *)
val from_unix_sockaddr : Unix.sockaddr -> sockaddr ptr

(** Convert a POSIX socket address to [Unix.sockaddr].

    @param addr The POSIX socket address to convert.
    @return The equivalent Unix socket address. *)
val to_unix_sockaddr : sockaddr ptr -> Unix.sockaddr
