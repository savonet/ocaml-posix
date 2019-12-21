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

let () =
  let fname = Sys.argv.(1) in
  let oc = open_out_bin fname in
  let format =
    Format.formatter_of_out_channel oc
  in
  Format.fprintf format "%s@\n" c_headers;
  Cstubs.Types.write_c format (module Posix_socket_constants.Def);
  Format.pp_print_flush format ();
  close_out oc
