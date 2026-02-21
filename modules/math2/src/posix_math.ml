include Posix_math_stubs.Def (Posix_math_generated_stubs)

type fp_type = [ `Infinite | `NaN | `Normal | `Subnormal | `Zero ]

let fpclassify f =
  match fpclassify f with
    | x when x = fp_infinite -> Some `Infinite
    | x when x = fp_nan -> Some `NaN
    | x when x = fp_normal -> Some `Normal
    | x when x = fp_subnormal -> Some `Subnormal
    | x when x = fp_zero -> Some `Zero
    | _ -> None

let huge_val = huge_val ()
let huge_valf = huge_valf ()
let huge_vall = huge_vall ()
let infinity = infinity ()
let nan_constant = nan_constant ()
let signgam = signgam ()
let m_e = m_e ()
let m_log2e = m_log2e ()
let m_log10e = m_log10e ()
let m_ln2 = m_ln2 ()
let m_ln10 = m_ln10 ()
let m_pi = m_pi ()
let m_pi_2 = m_pi_2 ()
let m_pi_4 = m_pi_4 ()
let m_1_pi = m_1_pi ()
let m_2_pi = m_2_pi ()
let m_2_sqrtpi = m_2_sqrtpi ()
let m_sqrt2 = m_sqrt2 ()
let m_sqrt1_2 = m_sqrt1_2 ()
