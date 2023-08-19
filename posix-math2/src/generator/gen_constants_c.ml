module Types = Posix_base.Generators.Types (struct
  module Types = Posix_math_constants.Def

  let c_headers =
    {|
#include <math.h>
#include <stdalign.h>

#define SIZEOF_FLOAT_T sizeof(float_t)
#define ALIGNOF_FLOAT_T alignof(float_t)
#define SIZEOF_DOUBLE_T sizeof(double_t)
#define ALIGNOF_DOUBLE_T alignof(double_t)
|}
end)

let () = Types.gen ()
