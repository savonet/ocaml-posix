module Types = Posix_base.Generators.Types (struct
  module Types = Posix_socket_unix_types.Def

  let c_headers =
    "\n#include <sys/socket.h>\n#include <sys/un.h>\n#include <netinet/in.h>\n"
end)

let () = Types.gen ()
