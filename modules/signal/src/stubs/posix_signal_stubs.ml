open Ctypes

module Def (F : Cstubs.FOREIGN) = struct
  open F
  module Types = Posix_signal_types.Def (Posix_signal_generated_types)
  open Types

  let sigemptyset = foreign "sigemptyset" (ptr sigset_t @-> returning int)
  let sigaddset = foreign "sigaddset" (ptr sigset_t @-> int @-> returning int)

  let sigismember =
    foreign "sigismember" (ptr sigset_t @-> int @-> returning int)

  let pthread_sigmask =
    foreign "pthread_sigmask"
      (int @-> ptr sigset_t @-> ptr sigset_t @-> returning int)

  let sigprocmask =
    foreign "sigprocmask"
      (int @-> ptr sigset_t @-> ptr sigset_t @-> returning int)
end
