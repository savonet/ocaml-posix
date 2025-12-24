module Types = Posix_base.Generators.Types (struct
  module Types = Posix_unistd_constants.Def

  let c_headers =
    {|
#include <unistd.h>
#include <fcntl.h>
#ifndef HOST_NAME_MAX
#define HOST_NAME_MAX 256
#endif
|}
end)

let () = Types.gen ()
