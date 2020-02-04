module Types = Posix_base.Generators.Types (struct
  module Types = Posix_signal_constants.Def

  let c_headers =
    {|
#include <signal.h>

#define SIGSET_SIZE sizeof(sigset_t)
#define SIGSET_ALIGNMENT offsetof(struct { char c; sigset_t x; }, x)
|}
end)

let () = Types.gen ()
