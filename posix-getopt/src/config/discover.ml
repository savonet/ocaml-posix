module C = Configurator.V1

let has_getopt_h_code = {|
#include <getopt.h>

int main()
{
  return 0;
}
|}

let has_optreset_code =
  {|
#include <getopt.h>

int main()
{
  int foo = optreset;
  return 0;
}
|}

let has_get_getopt_long_code =
  {|
#include <getopt.h>

int main()
{
  int ret = getopt_long(0, NULL, NULL, NULL, NULL);
  return 0;
}
|}

let has_get_getopt_long_only_code =
  {|
#include <getopt.h>

int main()
{
  int ret = getopt_long_only(0, NULL, NULL, NULL, NULL);
  return 0;
}
|}

let () =
  C.main ~name:"posix_getopt" (fun c ->
      let has_getopt_h = C.c_test c has_getopt_h_code in
      let has_optreset = C.c_test c has_optreset_code in
      let has_get_getopt_long = C.c_test c has_get_getopt_long_code in
      let has_get_getopt_long_only = C.c_test c has_get_getopt_long_only_code in

      C.C_define.gen_header_file c ~fname:"config.h"
        [
          ("HAS_GETOPT_H", Switch has_getopt_h);
          ("HAS_OPTRESET", Switch has_optreset);
          ("HAS_GETOPT_LONG", Switch has_get_getopt_long);
          ("HAS_GETOPT_LONG_ONLY", Switch has_get_getopt_long_only);
        ])
