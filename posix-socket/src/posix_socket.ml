open Ctypes
include Posix_socket_types
include Posix_socket_stubs.Def (Posix_socket_generated_stubs)

type sockaddr_storage = unit

let sockaddr_storage () = to_voidp (allocate_n char ~count:sockaddr_storage_len)

type socket_type = int

let socket_type_t = int
let from_sockaddr_storage t ptr = from_voidp t (to_voidp ptr)

module Addrinfo = Types.Addrinfo

module Sockaddr = struct
  include Types.Sockaddr

  let from_sockaddr_storage = from_sockaddr_storage t
  let sa_data_len = sa_data_len
end

type sockaddr = Sockaddr.t structure

let sockaddr_t = Sockaddr.t

type in_port = Unsigned.uint16

let in_port_t = uint16_t

module SockaddrInet = struct
  include Types.SockaddrInet

  let from_sockaddr_storage = from_sockaddr_storage t
end

type sockaddr_in = SockaddrInet.t structure

let sockaddr_in_t = SockaddrInet.t

module SockaddrInet6 = struct
  include Types.SockaddrInet6

  let from_sockaddr_storage = from_sockaddr_storage t
end

type sockaddr_in6 = SockaddrInet6.t structure

let sockaddr_in6_t = SockaddrInet6.t

let sockaddr_len s =
  match !@(s |-> Sockaddr.sa_family) with
    | id when id = af_inet -> sizeof sockaddr_in_t
    | id when id = af_inet6 -> sizeof sockaddr_in6_t
    | id ->
        failwith
          (Printf.sprintf "Unsupported socket family: %x" (Sa_family.to_int id))

let getnameinfo sockaddr_ptr =
  let s = allocate_n char ~count:ni_maxhost in
  let p = allocate_n char ~count:ni_maxserv in
  match
    getnameinfo sockaddr_ptr
      (Socklen.of_int (sizeof sockaddr_t))
      s
      (Socklen.of_int ni_maxhost)
      p
      (Socklen.of_int ni_maxserv)
      (ni_numerichost lor ni_numericserv)
  with
    | 0 ->
        let host =
          let length =
            Unsigned.Size_t.to_int
              (strnlen s (Unsigned.Size_t.of_int ni_maxhost))
          in
          string_from_ptr s ~length
        in
        let port =
          let length =
            Unsigned.Size_t.to_int
              (strnlen p (Unsigned.Size_t.of_int ni_maxserv))
          in
          let port = string_from_ptr p ~length in
          try int_of_string port
          with _ -> (
            match getservbyname p null with
              | ptr when is_null ptr -> failwith "getnameinfo"
              | ptr ->
                  Unsigned.UInt16.to_int
                    (ntohs !@(ptr |-> Types.Servent.s_port)))
        in
        (host, port)
    | _ -> failwith "getnameinfo"

let getaddrinfo =
  let rec get_sockaddr ~cur p =
    if is_null !@p then List.rev cur
    else (
      let addrinfo = !@p in
      let sockaddr_len =
        Socklen.to_int !@(addrinfo |-> Types.Addrinfo.ai_addrlen)
      in
      let sockaddr = to_voidp (allocate_n char ~count:sockaddr_len) in
      memcpy sockaddr
        (to_voidp !@(addrinfo |-> Types.Addrinfo.ai_addr))
        (Unsigned.Size_t.of_int sockaddr_len);
      get_sockaddr
        ~cur:(from_voidp Types.Sockaddr.t sockaddr :: cur)
        (addrinfo |-> Types.Addrinfo.ai_next))
  in
  fun ?hints ?port host ->
    let port =
      match port with
        | Some (`Int port) ->
            let s = string_of_int port in
            let c = CArray.of_string s in
            CArray.start c
        | Some (`String s) ->
            let c = CArray.of_string s in
            CArray.start c
        | None -> from_voidp char null
    in
    let p = allocate_n (ptr Addrinfo.t) ~count:1 in
    let hints =
      Option.value ~default:(from_voidp Types.Addrinfo.t null) hints
    in
    match getaddrinfo host port hints p with
      | 0 ->
          let ret = get_sockaddr ~cur:[] p in
          freeaddrinfo !@p;
          ret
      | _ -> failwith "getaddrinfo"

external alloc_sockaddr : _ Cstubs_internals.fatptr -> int -> Unix.sockaddr
  = "posix_socket_alloc_sockaddr"

let fatptr = function Cstubs_internals.CPointer s -> s

let to_unix_sockaddr s = alloc_sockaddr (fatptr s) (sockaddr_len s)

external get_sockaddr : Unix.sockaddr -> _ Cstubs_internals.fatptr -> unit
  = "posix_socket_get_sockaddr"

let from_unix_sockaddr s =
  let storage = sockaddr_storage () in
  get_sockaddr s (fatptr storage);
  Sockaddr.from_sockaddr_storage storage
