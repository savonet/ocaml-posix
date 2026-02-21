module Types = Posix_base.Generators.Types (struct
  module Types = Posix_signal_types.Def

  let c_headers = {|
#include <signal.h>
|}
end)

let () = Types.gen ()
