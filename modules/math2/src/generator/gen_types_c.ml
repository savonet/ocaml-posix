module Types = Posix_base.Generators.Types (struct
  module Types = Posix_math_types.Def

  let c_headers = {|
#include <math.h>
|}
end)

let () = Types.gen ()
