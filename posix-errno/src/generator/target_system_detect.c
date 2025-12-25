#include <stdio.h>

#define STRINGIFY(x) #x
#define TOSTRING(x) STRINGIFY(x)

int main() {
  printf("let system = Str.replace_first (Str.regexp \"ocaml_posix_\") \"\" \"%s\"\n",
         TOSTRING(OCAML_POSIX_ERRNO_SYSTEM));
  printf("let os_type = Str.replace_first (Str.regexp \"ocaml_posix_\") \"\" \"%s\"\n",
        TOSTRING(OCAML_POSIX_ERRNO_OS_TYPE));
  return 0;
}
