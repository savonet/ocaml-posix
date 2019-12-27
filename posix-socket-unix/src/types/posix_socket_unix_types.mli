open Ctypes
open Posix_socket_types

val af_unix : sa_family_t
val sun_path_len : int

module Def (S : Cstubs.Types.TYPE) : sig
  module SockaddrUnix : sig
    type t

    val t : t structure S.typ
    val sun_family : (sa_family_t, t structure) S.field
    val sun_path : (char carray, t structure) S.field
  end

  type sockaddr_un = SockaddrUnix.t structure

  val sockaddr_un_t : sockaddr_un S.typ
end
