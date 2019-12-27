module Types = Posix_base.Generators.Types (struct
  module Types = Posix_socket_constants.Def

  let c_headers =
    "\n\
     #ifdef _WIN32\n\
    \  #include <winsock2.h>\n\
    \  #include <ws2tcpip.h>\n\
     #else\n\
    \  #include <sys/socket.h>\n\
    \  #include <sys/un.h>\n\
    \  #include <netdb.h>\n\
     #endif\n\n\
     #define SA_DATA_LEN (sizeof(((struct sockaddr*)0)->sa_data))\n\
     #define SA_FAMILY_T_LEN (sizeof(((struct sockaddr*)0)->sa_family))\n\
     #define SOCKLEN_T_LEN (sizeof(socklen_t))\n\n\
     #ifndef NI_MAXHOST\n\
    \  #define NI_MAXHOST 1025\n\
     #endif\n\n\
     #ifndef NI_MAXSERV\n\
    \  #define NI_MAXSERV 32\n\
     #endif\n"
end)

let () = Types.gen ()
