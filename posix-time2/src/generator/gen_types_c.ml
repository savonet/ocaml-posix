module Types = Posix_base.Generators.Types (struct
  module Types = Posix_time2_types.Def

  let c_headers =
    {|
#ifdef _WIN32
  #include <winsock2.h>
  #include <time.h>

  // Windows doesn't have itimerval, provide dummy definition
  #ifndef _ITIMERVAL_DEFINED
  #define _ITIMERVAL_DEFINED
  struct itimerval {
    struct timeval it_interval;
    struct timeval it_value;
  };
  #endif
#else
  #include <time.h>
  #include <sys/time.h>
#endif
|}
end)

let () = Types.gen ()
