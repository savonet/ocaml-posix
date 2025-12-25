module Constants = Posix_base.Generators.Types (struct
  module Types = Posix_errno_constants.Def

  let c_headers =
    Printf.sprintf
      {|
#include <errno.h>

/* Provide default values for errno constants that might not be defined on all platforms */

%s
|}
      (Errno_defaults.generate_errno_defaults_c ())
end)

let () = Constants.gen ()
