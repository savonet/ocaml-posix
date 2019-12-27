open Ctypes
open Posix_socket
include Posix_socket_unix_types
module Types = Posix_socket_unix_types.Def (Posix_socket_unix_generated_types)

type sockaddr_un = Types.sockaddr_un

let sockaddr_un_t = Types.sockaddr_un_t
let from_ptr t ptr = from_voidp t (to_voidp ptr)

module SockaddrUnix = struct
  include Types.SockaddrUnix

  let from_sockaddr_storage = from_ptr t
  let sun_path_len = sun_path_len
end

let to_unix_sockaddr s =
  match !@(s |-> Sockaddr.sa_family) with
    | id when id = af_unix ->
        let s = from_ptr SockaddrUnix.t s in
        let path = !@(s |-> SockaddrUnix.sun_path) in
        let len =
          strnlen (CArray.start path)
            (Unsigned.Size_t.of_int (CArray.length path))
        in
        let path =
          string_from_ptr (CArray.start path)
            ~length:(Unsigned.Size_t.to_int len)
        in
        Unix.ADDR_UNIX path
    | _ -> to_unix_sockaddr s

let from_unix_sockaddr = function
  | Unix.ADDR_UNIX path ->
      let ss =
        allocate_n SockaddrStorage.t ~count:(sizeof sockaddr_storage_t)
      in
      let path =
        if String.length path > sun_path_len then String.sub path 0 sun_path_len
        else path
      in
      let ret = ref [] in
      String.iter (fun c -> ret := c :: !ret) path;
      let path = CArray.of_list char (List.rev !ret) in
      let s = SockaddrUnix.from_sockaddr_storage ss in
      s |-> SockaddrUnix.sun_family <-@ af_unix;
      s |-> SockaddrUnix.sun_path <-@ path;
      from_ptr Sockaddr.t ss
  | sockaddr -> from_unix_sockaddr sockaddr
