(** POSIX Unix domain socket bindings.

    This module provides OCaml bindings for Unix domain sockets (AF_UNIX),
    extending the {!Posix_socket} module with Unix-specific socket address
    types.

    Unix domain sockets provide local inter-process communication using
    filesystem paths as addresses.

    See
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_un.h.html}
     sys/un.h}. *)

open Ctypes
open Posix_socket

(** {1 Address Family} *)

(** Unix domain socket address family (AF_UNIX). *)
val af_unix : sa_family_t

(** {1 Unix Socket Address}

    The [sockaddr_un] structure for Unix domain sockets. *)

module SockaddrUnix : sig
  type t

  val t : t structure typ
  val sun_family : (sa_family_t, t structure) field
  val sun_path : (char carray, t structure) field
  val sun_path_len : int
  val from_sockaddr_storage : sockaddr_storage ptr -> t structure ptr
end

(** Type alias for Unix domain socket address. *)
type sockaddr_un = SockaddrUnix.t structure

(** Ctypes representation of sockaddr_un. *)
val sockaddr_un_t : sockaddr_un typ

(** {1 Unix Module Interoperability} *)

(** Convert a [Unix.sockaddr] to a POSIX socket address.

    Supports [Unix.ADDR_UNIX] addresses.

    @param addr The Unix socket address to convert.
    @return A pointer to the equivalent POSIX sockaddr. *)
val from_unix_sockaddr : Unix.sockaddr -> sockaddr ptr

(** Convert a POSIX socket address to [Unix.sockaddr].

    @param addr The POSIX socket address to convert.
    @return The equivalent [Unix.ADDR_UNIX] address. *)
val to_unix_sockaddr : sockaddr ptr -> Unix.sockaddr
