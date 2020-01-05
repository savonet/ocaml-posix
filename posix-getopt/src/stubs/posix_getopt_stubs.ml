open Ctypes

module Def (F : Cstubs.FOREIGN) = struct
  open F

  module Option = struct
    type t

    let t : t structure typ = structure "option"
    let name = field t "name" string
    let has_args = field t "has_args" int
    let flag = field t "flag" (ptr int)
    let value = field t "value" int
    let () = seal t
  end

  let getopt = foreign "getopt" (int @-> ptr string @-> string @-> returning int)

  let has_getopt_long = foreign "has_getopt_long" (void @-> returning bool)

  let getopt_long =
    foreign "getopt_long"
      ( int @-> ptr string @-> string @-> ptr Option.t @-> ptr int
      @-> returning int )

  let has_getopt_long_only = foreign "has_getopt_long_only" (void @-> returning bool)

  let getopt_long_only =
    foreign "getopt_long_only"
      ( int @-> ptr string @-> string @-> ptr Option.t @-> ptr int
      @-> returning int )

  let getoptarg = foreign "getoptarg" (void @-> returning (ptr char))
  let getoptind = foreign "getoptind" (void @-> returning (ptr int))
  let getopterr = foreign "getopterr" (void @-> returning (ptr int))
  let getoptopt = foreign "getoptopt" (void @-> returning (ptr int))
  let getoptreset = foreign "getoptreset" (void @-> returning (ptr int))
  let strlen = foreign "strlen" (ptr char @-> returning int)
end
