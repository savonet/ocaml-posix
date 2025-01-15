open Ctypes
include Posix_socket_types
include Posix_socket_stubs.Def (Posix_socket_generated_stubs)

type socket_type = int

let socket_type_t = int
let from_sockaddr_storage t ptr = from_voidp t (to_voidp ptr)

module SockaddrStorage = Types.SockaddrStorage

type sockaddr_storage = SockaddrStorage.t structure

let sockaddr_storage_t = SockaddrStorage.t

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
    | _ -> failwith "Not implemented"

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

let getaddrinfo host port =
  let port = string_of_int port in
  let hints = allocate_n Types.Addrinfo.t ~count:1 in
  hints |-> Types.Addrinfo.ai_flags <-@ ni_numerichost lor ni_numericserv;
  let p = allocate_n (ptr Types.Addrinfo.t) ~count:1 in
  let rec count len p =
    match !@p with
      | p when is_null p -> len
      | p -> count (len + 1) (p |-> Types.Addrinfo.ai_next)
  in
  let copy p =
    let count = count 0 p in
    let ret = allocate_n (ptr Types.Sockaddr.t) ~count:(count + 1) in
    let rec assign_sockaddr pos p =
      if not (is_null !@p) then (
        let addrinfo = !@p in
        let sockaddr =
          allocate Sockaddr.t !@(!@(addrinfo |-> Types.Addrinfo.ai_addr))
        in
        ret +@ pos <-@ sockaddr;
        assign_sockaddr (pos + 1) (addrinfo |-> Types.Addrinfo.ai_next))
      else ret +@ pos <-@ from_voidp Sockaddr.t null
    in
    assign_sockaddr 0 p;
    ret
  in
  match getaddrinfo host port hints p with
    | 0 ->
        let ret = copy p in
        freeaddrinfo !@p;
        ret
    | _ -> failwith "getaddrinfo"

let to_unix_sockaddr s =
  match !@(s |-> Sockaddr.sa_family) with
    | id when id = af_inet || id = af_inet6 ->
        let inet_addr, port = getnameinfo s in
        let inet_addr = Unix.inet_addr_of_string inet_addr in
        Unix.ADDR_INET (inet_addr, port)
    | _ -> failwith "Not implemented"

let from_unix_sockaddr = function
  | Unix.ADDR_UNIX _ -> failwith "Not implemented"
  | Unix.ADDR_INET (inet_addr, port) -> (
      let inet_addr = Unix.string_of_inet_addr inet_addr in
      match getaddrinfo inet_addr port with
        | p when is_null !@p -> failwith "Resolution failed!"
        | p -> !@p)
