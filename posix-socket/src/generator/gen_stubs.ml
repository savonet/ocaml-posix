module Stubs = Posix_base.Generators.Stubs (struct
  module Stubs = Posix_socket_stubs.Def

  let c_headers =
    "\n\
     #ifdef _WIN32\n\
    \  #include <winsock2.h>\n\
    \  #include <ws2tcpip.h>\n\
     #else\n\
    \  #include <sys/socket.h>\n\
    \  #include <netinet/in.h>\n\
    \  #include <arpa/inet.h>\n\
    \  #include <netdb.h>\n\
     #endif\n\n\
     #include <string.h>\n"

  let concurrency = Cstubs.unlocked
  let prefix = "posix_socket"
end)

let () = Stubs.gen ()
