module Def (S : Cstubs.Types.TYPE) = struct
  module Option = struct
    type t = unit

    let t = S.structure "option"
    let name = S.field t "name" S.string
    let has_arg = S.field t "has_arg" S.int
    let flag = S.field t "flag" (S.ptr S.int)
    let _val = S.field t "val" S.int
    let () = S.seal t
  end
end
