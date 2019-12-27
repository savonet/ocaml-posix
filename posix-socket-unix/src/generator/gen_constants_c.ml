module Types = Posix_base.Generators.Types (struct
  module Types = Posix_socket_unix_constants.Def

  let c_headers =
    "\n\
     #include <sys/socket.h>\n\
     #include <sys/un.h>\n\
     #define SUN_PATH_LEN (sizeof(((struct sockaddr_un *)0)->sun_path))\n"
end)

let () = Types.gen ()
