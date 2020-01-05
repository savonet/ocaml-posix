open Ctypes
module Constants = Posix_uname_constants.Def (Posix_uname_generated_constants)
include Constants

module Def (S : Cstubs.Types.TYPE) = struct
  module Utsname = struct
    type t = unit

    let t = S.structure "utsname"
    let sysname = S.field t "sysname" (S.array sysname_len S.char)
    let nodename = S.field t "nodename" (S.array nodename_len S.char)
    let release = S.field t "release" (S.array release_len S.char)
    let version = S.field t "version" (S.array version_len S.char)
    let machine = S.field t "machine" (S.array machine_len S.char)
    let () = S.seal t
  end
end
