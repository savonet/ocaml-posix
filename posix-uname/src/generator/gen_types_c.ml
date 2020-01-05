module Types = Posix_base.Generators.Types (struct
  module Types = Posix_uname_types.Def

  let c_headers = {|
#include <sys/utsname.h>
|}
end)

let () = Types.gen ()
