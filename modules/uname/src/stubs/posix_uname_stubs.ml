open Ctypes

module Def (F : Cstubs.FOREIGN) = struct
  open F
  module Types = Posix_uname_types.Def (Posix_uname_generated_types)
  open Types

  let uname = foreign "uname" (ptr Utsname.t @-> returning int)
  let strlen = foreign "strlen" (ptr char @-> returning int)
end
