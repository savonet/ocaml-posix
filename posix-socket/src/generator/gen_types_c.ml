module Types = Posix_base.Generators.Types (struct
  module Types = Posix_socket_types.Def

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
|}
end)

let () = Types.gen ()
