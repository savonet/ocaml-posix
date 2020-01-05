module Stubs = Posix_base.Generators.Stubs (struct
  module Stubs = Posix_socket_stubs.Def

  let c_headers =
    {|
#ifdef _WIN32
  #include <winsock2.h>
  #include <ws2tcpip.h>
#else
  #include <sys/socket.h>
  #include <netinet/in.h>
  #include <arpa/inet.h>
  #include <netdb.h>
#endif

#include <string.h>
|}

  let concurrency = Cstubs.unlocked
  let prefix = "posix_socket"
end)

let () = Stubs.gen ()
