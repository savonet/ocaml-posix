open Ctypes
open Posix_socket_types

module Constants = Posix_socket_unix_constants.Def(Posix_socket_unix_generated_constants)

include Constants

let af_unix = Sa_family.of_int af_unix

module Def (S : Cstubs.Types.TYPE) = struct
  let sa_family_t = S.lift_typ sa_family_t

  module SockaddrUnix = struct
    type t = unit

    let t = S.structure "sockaddr_un"
    let sun_family = S.field t "sun_family" sa_family_t
    let sun_path = S.field t "sun_path" (S.array sun_path_len S.char)
    let () = S.seal t
  end

  type sockaddr_un = SockaddrUnix.t structure
  let sockaddr_un_t : sockaddr_un S.typ = SockaddrUnix.t
end
