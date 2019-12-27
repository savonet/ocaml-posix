module Types = Posix_base.Generators.Types (struct
  module Types = Posix_socket_types.Def

  let c_headers =
    "\n\
     #ifdef _WIN32\n\
    \  #include <winsock2.h>\n\
    \  #include <ws2tcpip.h>\n\
     #else\n\
    \  #include <sys/socket.h>\n\
    \  #include <sys/un.h>\n\
    \  #include <netinet/in.h>\n\
    \  #include <netdb.h>\n\
     #endif\n"
end)

let () = Types.gen ()
