module Stubs = Posix_base.Generators.Stubs (struct
  module Stubs = Posix_getopt_stubs.Def

  let c_headers =
    {|
#include <unistd.h>
#include <string.h>
#include <errno.h>

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

static int *getoptind() {
  return &optind;
}

static int *getopterr() {
  return &opterr;
}

static int *getoptopt() {
  return &optopt;
}

static int *getoptreset() {
#ifdef HAS_OPTRESET
  return &optreset;
#else
  return NULL;
#endif
}

static char *getoptarg() {
  return optarg;
}

#ifndef HAS_GETOPT_LONG
static int has_getopt_long() {
  return 0;
}

int getopt_long(int x, char **y, const char *z, const struct option *t, int *u) {
  return ENOSYS;
}
#else
static int has_getopt_long() {
  return 1;
}
#endif

#ifndef HAS_GETOPT_LONG_ONLY
static int has_getopt_long_only() {
  return 0;
}

int getopt_long_only(int x, char **y, const char *z, const struct option *t, int *u) {
  return ENOSYS;
}
#else
static int has_getopt_long_only() {
  return 1;
}
#endif
|}

  let concurrency = Cstubs.unlocked
  let prefix = "posix_getopt"
end)

let () = Stubs.gen ()
