module Def (S : Cstubs.Types.TYPE) = struct
  let sizeof_float_t = S.constant "SIZEOF_FLOAT_T" S.int
  let alignof_float_t = S.constant "ALIGNOF_FLOAT_T" S.int
  let sizeof_double_t = S.constant "SIZEOF_DOUBLE_T" S.int
  let alignof_double_t = S.constant "ALIGNOF_DOUBLE_T" S.int
  let fp_infinite = S.constant "FP_INFINITE" S.int
  let fp_nan = S.constant "FP_NAN" S.int
  let fp_normal = S.constant "FP_NORMAL" S.int
  let fp_subnormal = S.constant "FP_SUBNORMAL" S.int
  let fp_zero = S.constant "FP_ZERO" S.int
end
