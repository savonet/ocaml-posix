open Ctypes

module Def (F : Cstubs.FOREIGN) = struct
  open F
  module Types = Posix_resource_types.Def (Posix_resource_generated_types)
  open Types

  (* Resource limit functions *)
  let getrlimit = foreign "getrlimit" (int @-> ptr Rlimit.t @-> returning int)
  let setrlimit = foreign "setrlimit" (int @-> ptr Rlimit.t @-> returning int)

  (* Resource usage functions *)
  let getrusage = foreign "getrusage" (int @-> ptr Rusage.t @-> returning int)

  (* Priority functions *)
  let getpriority = foreign "getpriority" (int @-> int @-> returning int)
  let setpriority = foreign "setpriority" (int @-> int @-> int @-> returning int)
end
