open Ctypes
open Posix_socket

let from_ptr t ptr = from_voidp t (to_voidp ptr)

let () =
  let host = Sys.argv.(1) in
  let resolved_addresses = getaddrinfo ~port:(`String Sys.argv.(2)) host in
  List.iter
    (fun sockaddr ->
      Printf.printf "sockaddr.sa_family = %d\n%!"
        (Sa_family.to_int !@(sockaddr |-> Sockaddr.sa_family));
      let sockaddr_in = from_ptr SockaddrInet.t sockaddr in
      Printf.printf "sockaddr_in.sin_addr.s_addr = %d\n%!"
        (Unsigned.UInt32.to_int
           (ntohl
              !@(sockaddr_in |-> SockaddrInet.sin_addr |-> SockaddrInet.s_addr))))
    resolved_addresses
