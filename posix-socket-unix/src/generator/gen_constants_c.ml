module Types = Posix_base.Generators.Types (struct
  module Types = Posix_socket_unix_constants.Def

  let c_headers =
    {|
#include <sys/socket.h>
#include <sys/un.h>
#define SUN_PATH_LEN (sizeof(((struct sockaddr_un *)0)->sun_path))
|}
end)

let () = Types.gen ()
