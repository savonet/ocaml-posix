open Ctypes

module Constants = Posix_socket_constants.Def(Posix_socket_generated_constants)

module type Socklen = functor (S : Cstubs.Types.TYPE) -> sig
  type socklen
  val socklen_t : socklen S.typ
  val int_of_socklen : socklen -> int
  val socklen_of_int : int -> socklen
end

let socklen : (module Socklen)  =
    match Constants.socklen_t_len with
      | 1 ->  (module functor (S : Cstubs.Types.TYPE) -> struct
                 type socklen = Unsigned.uint8
                 let socklen_t = S.uint8_t
                 let int_of_socklen = Unsigned.UInt8.to_int
                 let socklen_of_int = Unsigned.UInt8.of_int
               end)
      | 2 -> (module functor (S : Cstubs.Types.TYPE) -> struct
                 type socklen = Unsigned.uint16
                 let socklen_t = S.uint16_t
                 let int_of_socklen = Unsigned.UInt16.to_int
                 let socklen_of_int = Unsigned.UInt16.of_int
               end)
      | 4 -> (module functor (S : Cstubs.Types.TYPE) -> struct
                 type socklen = Unsigned.uint32
                 let socklen_t = S.uint32_t
                 let int_of_socklen = Unsigned.UInt32.to_int
                 let socklen_of_int = Unsigned.UInt32.of_int
               end)
      | 8 -> (module functor (S : Cstubs.Types.TYPE) -> struct
                 type socklen = Unsigned.uint64
                 let socklen_t = S.uint64_t
                 let int_of_socklen = Unsigned.UInt64.to_int
                 let socklen_of_int = Unsigned.UInt64.of_int
               end)
      | _ -> assert false

module Socklen = (val socklen : Socklen)

module type SaFamily = sig
  type sa_family
  val int_of_sa_family : sa_family -> int
  val sa_family_of_int : int -> sa_family
  
  module T : functor (S : Cstubs.Types.TYPE) -> sig
    val t : sa_family S.typ
  end
end

let saFamily : (module SaFamily)  =
    match Constants.sa_family_len with
      | 1 ->  (module struct
                 type sa_family = Unsigned.uint8
                 let int_of_sa_family = Unsigned.UInt8.to_int
                 let sa_family_of_int = Unsigned.UInt8.of_int                 
                 module T (S : Cstubs.Types.TYPE) = struct
                   let t = S.uint8_t
                 end
               end)
      | 2 -> (module struct
                 type sa_family = Unsigned.uint16
                 let int_of_sa_family = Unsigned.UInt16.to_int
                 let sa_family_of_int = Unsigned.UInt16.of_int
                 module T (S : Cstubs.Types.TYPE) = struct
                   let t = S.uint16_t
                 end
               end)
      | 4 -> (module struct
                 type sa_family = Unsigned.uint32
                 let int_of_sa_family = Unsigned.UInt32.to_int
                 let sa_family_of_int = Unsigned.UInt32.of_int
                 module T (S : Cstubs.Types.TYPE) = struct
                   let t = S.uint32_t
                 end
               end)
      | 8 -> (module struct
                 type sa_family = Unsigned.uint64
                 let int_of_sa_family = Unsigned.UInt64.to_int
                 let sa_family_of_int = Unsigned.UInt64.of_int
                 module T (S : Cstubs.Types.TYPE) = struct
                   let t = S.uint64_t
                 end
               end)
      | _ -> assert false

module SaFamily = (val saFamily : SaFamily)

module Def (S : Cstubs.Types.TYPE) = struct
  include Constants

  include Socklen(S)

  include SaFamily

  let af_inet = sa_family_of_int af_inet
  let af_inet6 = sa_family_of_int af_inet6
  let af_unspec = sa_family_of_int af_unspec

  module SaFamilyT = SaFamily.T(S)

  let sa_family_t = S.typedef SaFamilyT.t "sa_family_t"

  module Sockaddr = struct
    type t = unit
    let t = S.structure "sockaddr"
    let sa_family = S.field t "sa_family" sa_family_t
    let sa_data = S.field t "sa_data" (S.array sa_data_len S.char)
    let () = S.seal t
  end

  type sockaddr = Sockaddr.t structure
  let sockaddr_t : sockaddr S.typ = Sockaddr.t

  module Addrinfo = struct
    type t = unit
    let t = S.structure "addrinfo"
    let ai_flags = S.field t "ai_flags" S.int
    let ai_addrlen = S.field t "ai_addrlen" socklen_t
    let ai_addr = S.field t "ai_addr" (S.ptr Sockaddr.t)
    let () = S.seal t
  end

  module Servent = struct
    type t = unit
    let t = S.structure "servent"
    let s_port = S.field t "s_port" S.uint16_t
    let () = S.seal t
  end

  module SockaddrStorage = struct
    type t = unit
    let t = S.structure "sockaddr_storage"
    let ss_family = S.field t "ss_family" sa_family_t
    let () = S.seal t
  end

  type sockaddr_storage = SockaddrStorage.t structure
  let sockaddr_storage_t : sockaddr_storage S.typ = SockaddrStorage.t

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
    let sin_addr  = S.field t "sin_addr " in_addr
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
    let sin6_addr  = S.field t "sin6_addr" in6_addr
    let sin6_scope_id = S.field t "sin6_scope_id" S.uint32_t
    let () = S.seal t
  end

  type sockaddr_in6 = SockaddrInet6.t structure
  let sockaddr_in6_t : sockaddr_in6 S.typ = SockaddrInet6.t
end
