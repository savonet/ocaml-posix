module Types = Posix_base.Generators.Types (struct
  module Types = Posix_unistd_types.Def

  let c_headers = {|
#include <unistd.h>
|}
end)

let () = Types.gen ()
