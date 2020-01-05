open Ctypes

module Def (F : Cstubs.FOREIGN) = struct
  open F

  module Types = Posix_getopt_types.Def (Posix_getopt_generated_types)
  include Types

  let getopt = foreign "getopt" (int @-> ptr string @-> string @-> returning int)
  let has_getopt_long = foreign "has_getopt_long" (void @-> returning bool)

  let getopt_long =
    foreign "getopt_long"
      ( int @-> ptr string @-> string @-> ptr Option.t @-> ptr int
      @-> returning int )

  let has_getopt_long_only =
    foreign "has_getopt_long_only" (void @-> returning bool)

  let getopt_long_only =
    foreign "getopt_long_only"
      ( int @-> ptr string @-> string @-> ptr Option.t @-> ptr int
      @-> returning int )

  let getoptarg = foreign "getoptarg" (void @-> returning (ptr char))
  let getoptind = foreign "getoptind" (void @-> returning (ptr int))
  let getopterr = foreign "getopterr" (void @-> returning (ptr bool))
  let getoptopt = foreign "getoptopt" (void @-> returning (ptr char))
  let getoptreset = foreign "getoptreset" (void @-> returning (ptr int))
  let strlen = foreign "strlen" (ptr char @-> returning int)
end
