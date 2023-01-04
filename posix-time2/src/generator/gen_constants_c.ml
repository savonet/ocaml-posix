module Constants = Posix_base.Generators.Types (struct
  module Types = Posix_time2_constants.Def

  let c_headers =
    {|
#include <time.h>
#include <sys/time.h>

// Some macos are missing these defines:
#ifdef __MACH__

#ifndef CLOCK_REALTIME
#define CLOCK_REALTIME 0
#endif

#ifndef CLOCK_MONOTONIC
#define CLOCK_MONOTONIC 1
#endif

#ifndef TIMER_ABSTIME
#define TIMER_ABSTIME 1
#endif

#endif

#define FD_SET_SIZE sizeof(fd_set)
#define FD_SET_ALIGNMENT offsetof(struct { char c; fd_set x; }, x)
|}
end)

let () = Constants.gen ()
