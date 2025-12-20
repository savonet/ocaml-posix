open Ctypes
module Constants = Posix_socket_constants.Def (Posix_socket_generated_constants)

let socklen : (module Posix_base.Types.Unsigned) =
  Posix_base.Types.mkUnsigned ~name:"socklen_t" ~size:Constants.socklen_t_len

let sockaddr_storage_len = Constants.sockaddr_storage_len

module Socklen = (val socklen : Posix_base.Types.Unsigned)

type socklen_t = Socklen.t

let socklen_t = Socklen.t

let sa_family : (module Posix_base.Types.Unsigned) =
  Posix_base.Types.mkUnsigned ~name:"sa_family_t"
    ~size:Constants.sa_family_t_len

module Sa_family = (val sa_family : Posix_base.Types.Unsigned)

type sa_family_t = Sa_family.t

let sa_family_t = Sa_family.t

include Constants

let af_inet = Sa_family.of_int af_inet
let af_inet6 = Sa_family.of_int af_inet6
let af_unspec = Sa_family.of_int af_unspec

module Def (S : Cstubs.Types.TYPE) = struct
  let sa_family_t = S.lift_typ sa_family_t
  let socklen_t = S.lift_typ socklen_t

  module Sockaddr = struct
    type t = unit

    let t = S.structure "sockaddr"
    let sa_family = S.field t "sa_family" sa_family_t
    let () = S.seal t
  end

  type sockaddr = Sockaddr.t structure

  let sockaddr_t : sockaddr S.typ = Sockaddr.t

  module Addrinfo = struct
    type t = unit

    let t = S.structure "addrinfo"
    let ai_flags = S.field t "ai_flags" S.int
    let ai_family = S.field t "ai_family" sa_family_t
    let ai_socktype = S.field t "ai_socktype" S.int
    let ai_protocol = S.field t "ai_protocol" S.int
    let ai_addrlen = S.field t "ai_addrlen" socklen_t
    let ai_addr = S.field t "ai_addr" (S.ptr Sockaddr.t)
    let ai_next = S.field t "ai_next" (S.ptr t)
    let () = S.seal t
  end

  module Servent = struct
    type t = unit

    let t = S.structure "servent"
    let s_port = S.field t "s_port" S.uint16_t
    let () = S.seal t
  end

  type in_port = Unsigned.uint16

  let in_port_t = S.uint16_t

  module SockaddrInet = struct
    type in_addr = Unsigned.uint32

    let in_addr_t = S.uint32_t
    let in_addr = S.structure "in_addr"
    let s_addr = S.field in_addr "s_addr" in_addr_t
    let () = S.seal in_addr

    type t = unit

    let t = S.structure "sockaddr_in"
    let sin_family = S.field t "sin_family" sa_family_t
    let sin_port = S.field t "sin_port" in_port_t
    let sin_addr = S.field t "sin_addr " in_addr
    let () = S.seal t
  end

  type sockaddr_in = SockaddrInet.t structure

  let sockaddr_in_t : sockaddr_in S.typ = SockaddrInet.t

  module SockaddrInet6 = struct
    type in6_addr = Unsigned.uint8 carray

    let in6_addr = S.structure "in6_addr"
    let s6_addr = S.field in6_addr "s6_addr" (S.array 16 S.uint8_t)
    let () = S.seal in6_addr

    type t = unit

    let t = S.structure "sockaddr_in6"
    let sin6_family = S.field t "sin6_family" sa_family_t
    let sin6_port = S.field t "sin6_port" in_port_t
    let sin6_flowinfo = S.field t "sin6_flowinfo" S.uint32_t
    let sin6_addr = S.field t "sin6_addr" in6_addr
    let sin6_scope_id = S.field t "sin6_scope_id" S.uint32_t
    let () = S.seal t
  end

  type sockaddr_in6 = SockaddrInet6.t structure

  let sockaddr_in6_t : sockaddr_in6 S.typ = SockaddrInet6.t
end
