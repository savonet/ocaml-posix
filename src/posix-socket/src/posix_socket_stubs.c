#ifdef _WIN32
#include <ws2tcpip.h>
#endif

#include <caml/memory.h>
#include <caml/mlvalues.h>
#include <caml/socketaddr.h>

#include "ctypes_cstubs_internals.h"
#include "posix_socket_stubs.h"

CAMLprim value posix_socket_get_sockaddr(value socket, value socket_storage) {
  CAMLparam2(socket, socket_storage);
  union sock_addr_union *sockaddr = CTYPES_ADDR_OF_FATPTR(socket_storage);
  socklen_param_type addr_len;
#ifdef HAS_CAML_UNIX_GET_SOCKADDR
  caml_unix_get_sockaddr(socket, sockaddr, &addr_len);
#else
  get_sockaddr(socket, sockaddr, &addr_len);
#endif
  CAMLreturn(Val_unit);
}

CAMLprim value posix_socket_alloc_sockaddr(value socket_addr_ptr,
                                           value socket_addr_len) {
  CAMLparam2(socket_addr_ptr, socket_addr_len);
  union sock_addr_union *sockaddr = CTYPES_ADDR_OF_FATPTR(socket_addr_ptr);
  size_t sockaddr_len = Int_val(socket_addr_len);
#ifdef HAS_CAML_UNIX_GET_SOCKADDR
  value socket = acaml_unix_alloc_sockaddr(sockaddr, sockaddr_len, -1);
#else
  value socket = alloc_sockaddr(sockaddr, sockaddr_len, -1);
#endif
  CAMLreturn(socket);
}
