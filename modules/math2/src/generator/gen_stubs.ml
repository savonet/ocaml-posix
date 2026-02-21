module Stubs = Posix_base.Generators.Stubs (struct
  module Stubs = Posix_math_stubs.Def

  let c_headers =
    {|
#include <math.h>

double ocaml_posix_math_huge_val() {
  return HUGE_VAL;
}

float ocaml_posix_math_huge_valf() {
  return HUGE_VALF;
}

long double ocaml_posix_math_huge_vall() {
  return HUGE_VALL;
}

float ocaml_posix_math_infinity() {
  return INFINITY;
}

float ocaml_posix_math_nan() {
  return NAN;
}

int *ocaml_posix_math_signgam() {
  return &signgam;
}

double ocaml_posix_math_m_e() {
  return M_E;
};

double ocaml_posix_math_m_log2e() {
  return M_LOG2E;
};

double ocaml_posix_math_m_log10e() {
  return M_LOG10E;
};

double ocaml_posix_math_m_ln2() {
  return M_LN2;
};

double ocaml_posix_math_m_ln10() {
  return M_LN10;
};

double ocaml_posix_math_m_pi() {
  return M_PI;
};

double ocaml_posix_math_m_pi_2() {
  return M_PI_2;
};

double ocaml_posix_math_m_pi_4() {
  return M_PI_4;
};

double ocaml_posix_math_m_1_pi() {
  return M_1_PI;
};

double ocaml_posix_math_m_2_pi() {
  return M_2_PI;
};

double ocaml_posix_math_m_2_sqrtpi() {
  return M_2_SQRTPI;
};

double ocaml_posix_math_m_sqrt2() {
  return M_SQRT2;
};

double ocaml_posix_math_m_sqrt1_2() {
  return M_SQRT1_2;
};
|}

  let concurrency = Cstubs.unlocked
  let prefix = "posix_math"
end)

let () = Stubs.gen ()
