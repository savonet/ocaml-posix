module Constants = Posix_math_constants.Def (Posix_math_generated_constants)

module Def (S : Cstubs.Types.TYPE) = struct
  include Constants

  let float_t = S.typedef S.float "float_t"
  let double_t = S.typedef S.double "double_t"
end
