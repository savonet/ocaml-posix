open Ctypes
open Posix_socket

let from_ptr t ptr = from_voidp t (to_voidp ptr)

let () =
  let host = Sys.argv.(1) in
  let p = getaddrinfo ~port:(`String Sys.argv.(2)) host in
  let rec print_sockaddr pos =
    if not (is_null !@(p +@ pos)) then (
      let sockaddr = !@p in
      Printf.printf "sockaddr.sa_family = %d\n%!"
        (Sa_family.to_int !@(sockaddr |-> Sockaddr.sa_family));
      let sockaddr_in = from_ptr SockaddrInet.t sockaddr in
      Printf.printf "sockaddr_in.sin_addr.s_addr = %d\n%!"
        (Unsigned.UInt32.to_int
           (ntohl
              !@(sockaddr_in |-> SockaddrInet.sin_addr |-> SockaddrInet.s_addr)));
      print_sockaddr (pos + 1))
  in
  print_sockaddr 0
