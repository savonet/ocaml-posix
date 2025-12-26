module Types = Posix_base.Generators.Types (struct
  module Types = Posix_stat_types.Def

  let c_headers =
    {|
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/time.h>
#include <time.h>
/* Platform compatibility for macOS */
#ifdef __APPLE__
  #define st_atim st_atimespec
  #define st_mtim st_mtimespec
  #define st_ctim st_ctimespec
#endif
|}
end)

let () = Types.gen ()
