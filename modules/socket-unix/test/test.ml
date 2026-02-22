open Ctypes
open Posix_socket
open Posix_socket_unix

let from_ptr t ptr = from_voidp t (to_voidp ptr)

let () =
  let sockaddr = from_unix_sockaddr (Unix.ADDR_UNIX "/path/to/socket") in
  let sockaddr_un = from_ptr SockaddrUnix.t sockaddr in
  Printf.printf "sockaddr_un.sun_family = %d\n%!"
    (Sa_family.to_int !@(sockaddr_un |-> SockaddrUnix.sun_family));
  let unix_socket = to_unix_sockaddr sockaddr in
  match unix_socket with
    | Unix.ADDR_UNIX path -> Printf.printf "Unix.ADDR_UNIX(%S)\n%!" path
    | _ -> assert false
