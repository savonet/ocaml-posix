module Constants = Posix_signal_constants.Def (Posix_signal_generated_constants)
include Constants

module Def (S : Cstubs.Types.TYPE) = struct
  open Ctypes

  type sigset_t = unit Ctypes.abstract

  let sigset_t =
    abstract ~name:"sigset_t" ~size:sigset_size ~alignment:sigset_alignment
end
