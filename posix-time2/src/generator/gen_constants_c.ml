module Constants = Posix_base.Generators.Types (struct
  module Types = Posix_time2_constants.Def

  let c_headers =
    {|
#ifdef _WIN32
  #include <winsock2.h>
  #include <time.h>

  // MinGW-w64 provides these via winpthreads
  // but some constants may be missing
  #ifndef CLOCK_REALTIME
  #define CLOCK_REALTIME 0
  #endif

  #ifndef CLOCK_MONOTONIC
  #define CLOCK_MONOTONIC 1
  #endif

  #ifndef TIMER_ABSTIME
  #define TIMER_ABSTIME 1
  #endif

  // These are not available on Windows
  #ifndef CLOCK_PROCESS_CPUTIME_ID
  #define CLOCK_PROCESS_CPUTIME_ID 2
  #endif

  #ifndef CLOCK_THREAD_CPUTIME_ID
  #define CLOCK_THREAD_CPUTIME_ID 3
  #endif

  // itimer not supported on Windows
  #ifndef ITIMER_REAL
  #define ITIMER_REAL 0
  #endif

  #ifndef ITIMER_VIRTUAL
  #define ITIMER_VIRTUAL 1
  #endif

  #ifndef ITIMER_PROF
  #define ITIMER_PROF 2
  #endif
#else
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
#endif

#define FD_SET_SIZE sizeof(fd_set)
#define FD_SET_ALIGNMENT offsetof(struct { char c; fd_set x; }, x)
|}
end)

let () = Constants.gen ()
