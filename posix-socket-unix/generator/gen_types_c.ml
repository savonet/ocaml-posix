module Types = Posix_base.Generators.Types(struct
  module Types = Posix_socket_unix_types.Def
  let c_headers = "
#include <sys/socket.h>
#include <sys/un.h>
#include <netinet/in.h>
"
end)

let () =
  Types.gen ()
