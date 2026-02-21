module Types = Posix_base.Generators.Types (struct
  module Types = Posix_getopt_types.Def

  let c_headers =
    {|
#include "config.h"

#ifdef HAS_GETOPT_H
#include <getopt.h>
#else
struct option {
  char *name;
  int has_arg;
  int *flag;
  int val;
};
#endif
|}
end)

let () = Types.gen ()
