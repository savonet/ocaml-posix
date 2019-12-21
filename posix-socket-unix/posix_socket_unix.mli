open Ctypes
open Posix_socket

(** Socket types constants. *)
val af_unix     : sa_family

(** Unix socket_un structure. *)
module SockaddrUnix : sig
  type t
  val t : t structure typ
  val sun_family : (sa_family, t structure) field 
  val sun_path : (char carray, t structure) field 
  val sun_path_len : int

  val from_sockaddr_storage : SockaddrStorage.t structure ptr -> t structure ptr
end

type sockaddr_un = SockaddrUnix.t structure
val sockaddr_un_t : sockaddr_un typ

(** Interface with the [Unix] module. *)
val from_unix_sockaddr : Unix.sockaddr -> sockaddr ptr
val to_unix_sockaddr : sockaddr ptr -> Unix.sockaddr
