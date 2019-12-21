module Types = Posix_base.Generators.Types(struct
  module Types = Posix_socket_constants.Def
  let c_headers = "
#ifdef _WIN32
  #include <winsock2.h>
  #include <ws2tcpip.h>
#else
  #include <sys/socket.h>
  #include <sys/un.h>
  #include <netdb.h>
#endif

#define SA_DATA_LEN (sizeof(((struct sockaddr*)0)->sa_data))
#define SA_FAMILY_LEN (sizeof(((struct sockaddr*)0)->sa_family))
#define SOCKLEN_T_LEN (sizeof(socklen_t))

#ifndef NI_MAXHOST
  #define NI_MAXHOST 1025
#endif

#ifndef NI_MAXSERV
  #define NI_MAXSERV 32
#endif
"
end)

let () =
  Types.gen ()
