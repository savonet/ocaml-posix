open Ctypes
open Posix_socket

let () =
  Printf.printf "sizeof(socklen_t) = %d\n%!" (sizeof socklen_t)

let from_ptr t ptr =
  from_voidp t (to_voidp ptr)

let () =
  let inet_addr =
    Unix.inet_addr_of_string "0.0.0.1"
  in
  let sockaddr =
    from_unix_sockaddr (Unix.ADDR_INET (inet_addr,80))
  in
  Printf.printf "sockaddr.sa_family = %d\n%!"
    (int_of_sa_family
      (!@ (sockaddr |-> Sockaddr.sa_family)));
  let sockaddr_in =
    from_ptr SockaddrInet.t sockaddr
  in
  Printf.printf "sockaddr_in.sin_addr.s_addr = %d\n%!"
    (Unsigned.UInt32.to_int
      (ntohl
        (!@ ((sockaddr_in |-> SockaddrInet.sin_addr) |-> SockaddrInet.s_addr))));
  let unix_socket =
    to_unix_sockaddr sockaddr
  in
  match unix_socket with
    | Unix.ADDR_INET (inet_addr,port) ->
         Printf.printf "Unix.ADDR_INET(%S,%d)\n%!" (Unix.string_of_inet_addr inet_addr) port
    | _ -> assert false
