module C = Configurator.V1

let has_caml_unix_get_sockaddr_c =
  {|
#ifdef _WIN32
#include <ws2tcpip.h>
#endif

#include <caml/mlvalues.h>
#include <caml/socketaddr.h>

int main() {
  union sock_addr_union sockaddr;
  socklen_param_type addr_len;
  value s;
  caml_unix_get_sockaddr(s, &sockaddr, &addr_len);
  return 0;
}
|}

let () =
  C.main ~name:"posix-socket" (fun c ->
      let has_caml_unix_get_sockaddr =
        C.c_test c ~link_flags:["-lcamlrun"] has_caml_unix_get_sockaddr_c
      in
      C.C_define.gen_header_file c ~fname:"posix_socket_stubs.h"
        [
          ( "HAS_CAML_UNIX_GET_SOCKADDR",
            C.C_define.Value.Switch has_caml_unix_get_sockaddr );
        ])
