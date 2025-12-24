module Stubs = Posix_base.Generators.Stubs (struct
  module Stubs = Posix_time2_stubs.Def

  let c_headers =
    {|
#ifdef _WIN32
  #include <winsock2.h>
  #include <time.h>

  // On Windows, link with winpthread for clock functions
  // MinGW-w64 provides these via winpthreads
#else
  #include <time.h>
  #include <sys/time.h>
#endif

static inline void ocaml_posix_time2_fd_zero(fd_set *fdset) {
  FD_ZERO(fdset);
}

static inline void ocaml_posix_time2_fd_set(int fd, fd_set *fdset) {
  FD_SET(fd, fdset);
}

static inline int ocaml_posix_time2_fd_isset(int fd, fd_set *fdset) {
  return FD_ISSET(fd, fdset);
}

static inline void ocaml_posix_time2_fd_clr(int fd, fd_set *fdset) {
  FD_CLR(fd, fdset);
}

#ifdef __MACH__

#define TIMING_GIGA (1000000000)

/* timespec difference (monotonic) right - left */
inline void timespec_monodiff_rml(struct timespec *ts_out,
                                    const struct timespec *ts_in) {
    ts_out->tv_sec = ts_in->tv_sec - ts_out->tv_sec;
    ts_out->tv_nsec = ts_in->tv_nsec - ts_out->tv_nsec;
    if (ts_out->tv_nsec < 0) {
        ts_out->tv_sec = ts_out->tv_sec - 1;
        ts_out->tv_nsec = ts_out->tv_nsec + TIMING_GIGA;
    }
}

inline int clock_nanosleep(clock_t clock_id, int flags, const struct timespec *req, struct timespec *rem) {
  struct timespec ts_delta;
  if (flags == 0) {
    // clock_id is ignored in this case
    return nanosleep(req, rem);
  }

  int retval = clock_gettime(clock_id, &ts_delta );
  if (retval != 0) return retval;

  timespec_monodiff_rml(&ts_delta, req);
  return nanosleep(&ts_delta, NULL);
}

#endif
|}

  let concurrency = Cstubs.unlocked
  let prefix = "posix_time2"
end)

let () = Stubs.gen ()
