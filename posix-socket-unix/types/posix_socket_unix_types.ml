open Ctypes
open Posix_socket_types

module Constants = Posix_socket_unix_constants.Def(Posix_socket_unix_generated_constants)

module Def (S : Cstubs.Types.TYPE) = struct
  include Constants

  module T = SaFamily.T(S)

  let af_unix = SaFamily.sa_family_of_int af_unix

  module SockaddrUnix = struct
    type t = unit

    let t = S.structure "sockaddr_un"
    let sun_family = S.field t "sun_family" T.t
    let sun_path = S.field t "sun_path" (S.array sun_path_len S.char)
    let () = S.seal t
  end

  type sockaddr_un = SockaddrUnix.t structure
  let sockaddr_un_t : sockaddr_un S.typ = SockaddrUnix.t
end
