open Ctypes
open Posix_socket_types

module Def (S : Cstubs.Types.TYPE) : sig 
  val af_unix      : SaFamily.sa_family
  val sun_path_len : int
  
  module SockaddrUnix : sig
    type t

    val t : t structure S.typ
    val sun_family : (SaFamily.sa_family, t structure) S.field 
    val sun_path : (char carray, t structure) S.field 
  end

  type sockaddr_un = SockaddrUnix.t structure
  val sockaddr_un_t : sockaddr_un S.typ
end
