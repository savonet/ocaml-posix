(** POSIX mathematical functions bindings.

    This module provides OCaml bindings to the POSIX math functions defined in
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/math.h.html} math.h}.

    Functions are provided in three variants:
    - Double precision: [sin], [cos], etc.
    - Single precision (float): [sinf], [cosf], etc.
    - Extended precision (long double): [sinl], [cosl], etc.

    Most functions map directly to their C equivalents. *)

open Ctypes

(** {1 Floating-Point Classification} *)

(** Result of floating-point classification. *)
type fp_type =
  [ `Infinite    (** Positive or negative infinity *)
  | `NaN         (** Not a number *)
  | `Normal      (** Normal floating-point number *)
  | `Subnormal   (** Subnormal (denormalized) number *)
  | `Zero ]      (** Positive or negative zero *)

(** Classify a floating-point value.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/fpclassify.html} fpclassify(3)}. *)
val fpclassify : float -> fp_type option

(** Test if a value is finite (not infinite and not NaN). *)
val isfinite : float -> bool

(** Test if a value is infinite. *)
val isinf : float -> bool

(** Test if a value is NaN (not a number). *)
val isnan : float -> bool

(** Test if a value is a normal number (not zero, subnormal, infinite, or NaN). *)
val isnormal : float -> bool

(** Test if a value is negative (including negative zero). *)
val signbit : float -> bool

(** {1 Comparison Macros} *)

(** [isgreater x y] is [true] if [x > y], without raising exceptions for NaN. *)
val isgreater : float -> float -> bool

(** [isgreaterequal x y] is [true] if [x >= y], without raising exceptions for NaN. *)
val isgreaterequal : float -> float -> bool

(** [isless x y] is [true] if [x < y], without raising exceptions for NaN. *)
val isless : float -> float -> bool

(** [islessequal x y] is [true] if [x <= y], without raising exceptions for NaN. *)
val islessequal : float -> float -> bool

(** [islessgreater x y] is [true] if [x < y] or [x > y], without raising exceptions for NaN. *)
val islessgreater : float -> float -> bool

(** [isunordered x y] is [true] if either [x] or [y] is NaN. *)
val isunordered : float -> float -> bool

(** {1 Mathematical Constants} *)

(** e (Euler's number) *)
val m_e : float

(** log2(e) *)
val m_log2e : float

(** log10(e) *)
val m_log10e : float

(** ln(2) *)
val m_ln2 : float

(** ln(10) *)
val m_ln10 : float

(** pi *)
val m_pi : float

(** pi/2 *)
val m_pi_2 : float

(** pi/4 *)
val m_pi_4 : float

(** 1/pi *)
val m_1_pi : float

(** 2/pi *)
val m_2_pi : float

(** 2/sqrt(pi) *)
val m_2_sqrtpi : float

(** sqrt(2) *)
val m_sqrt2 : float

(** 1/sqrt(2) *)
val m_sqrt1_2 : float

(** {1 Special Values} *)

(** Large positive double value (may be infinity) *)
val huge_val : float

(** Large positive float value *)
val huge_valf : float

(** Large positive long double value *)
val huge_vall : LDouble.t

(** Positive infinity *)
val infinity : float

(** A quiet NaN value *)
val nan_constant : float

(** {1 Ctypes} *)

val float_t : float typ
val double_t : float typ

(** Sign of gamma function result *)
val signgam : int ptr

(** {1 Trigonometric Functions} *)

val acos : float -> float
val acosf : float -> float
val acosl : LDouble.t -> LDouble.t
val asin : float -> float
val asinf : float -> float
val asinl : LDouble.t -> LDouble.t
val atan : float -> float
val atanf : float -> float
val atanl : LDouble.t -> LDouble.t
val atan2 : float -> float -> float
val atan2f : float -> float -> float
val atan2l : LDouble.t -> LDouble.t -> LDouble.t
val cos : float -> float
val cosf : float -> float
val cosl : LDouble.t -> LDouble.t
val sin : float -> float
val sinf : float -> float
val sinl : LDouble.t -> LDouble.t
val tan : float -> float
val tanf : float -> float
val tanl : LDouble.t -> LDouble.t

(** {1 Hyperbolic Functions} *)

val acosh : float -> float
val acoshf : float -> float
val acoshl : LDouble.t -> LDouble.t
val asinh : float -> float
val asinhf : float -> float
val asinhl : LDouble.t -> LDouble.t
val atanh : float -> float
val atanhf : float -> float
val atanhl : LDouble.t -> LDouble.t
val cosh : float -> float
val coshf : float -> float
val coshl : LDouble.t -> LDouble.t
val sinh : float -> float
val sinhf : float -> float
val sinhl : LDouble.t -> LDouble.t
val tanh : float -> float
val tanhf : float -> float
val tanhl : LDouble.t -> LDouble.t

(** {1 Exponential and Logarithmic Functions} *)

val exp : float -> float
val expf : float -> float
val expl : LDouble.t -> LDouble.t
val exp2 : float -> float
val exp2f : float -> float
val exp2l : LDouble.t -> LDouble.t
val expm1 : float -> float
val expm1f : float -> float
val expm1l : LDouble.t -> LDouble.t
val frexp : float -> int ptr -> float
val frexpf : float -> int ptr -> float
val frexpl : LDouble.t -> int ptr -> LDouble.t
val ilogb : float -> int
val ilogbf : float -> int
val ilogbl : LDouble.t -> int
val ldexp : float -> int -> float
val ldexpf : float -> int -> float
val ldexpl : LDouble.t -> int -> LDouble.t
val log : float -> float
val logf : float -> float
val logl : LDouble.t -> LDouble.t
val log10 : float -> float
val log10f : float -> float
val log10l : LDouble.t -> LDouble.t
val log1p : float -> float
val log1pf : float -> float
val log1pl : LDouble.t -> LDouble.t
val log2 : float -> float
val log2f : float -> float
val log2l : LDouble.t -> LDouble.t
val logb : float -> float
val logbf : float -> float
val logbl : LDouble.t -> LDouble.t
val modf : float -> float ptr -> float
val modff : float -> float ptr -> float
val modfl : LDouble.t -> LDouble.t ptr -> LDouble.t
val scalbln : float -> Signed.Long.t -> float
val scalblnf : float -> Signed.Long.t -> float
val scalblnl : LDouble.t -> Signed.Long.t -> LDouble.t
val scalbn : float -> int -> float
val scalbnf : float -> int -> float
val scalbnl : LDouble.t -> int -> LDouble.t

(** {1 Power and Absolute Value Functions} *)

val cbrt : float -> float
val cbrtf : float -> float
val cbrtl : LDouble.t -> LDouble.t
val fabs : float -> float
val fabsf : float -> float
val fabsl : LDouble.t -> LDouble.t
val hypot : float -> float -> float
val hypotf : float -> float -> float
val hypotl : LDouble.t -> LDouble.t -> LDouble.t
val pow : float -> float -> float
val powf : float -> float -> float
val powl : LDouble.t -> LDouble.t -> LDouble.t
val sqrt : float -> float
val sqrtf : float -> float
val sqrtl : LDouble.t -> LDouble.t

(** {1 Error and Gamma Functions} *)

val erf : float -> float
val erff : float -> float
val erfl : LDouble.t -> LDouble.t
val erfc : float -> float
val erfcf : float -> float
val erfcl : LDouble.t -> LDouble.t
val lgamma : float -> float
val lgammaf : float -> float
val lgammal : LDouble.t -> LDouble.t
val tgamma : float -> float
val tgammaf : float -> float
val tgammal : LDouble.t -> LDouble.t

(** {1 Nearest Integer Functions} *)

val ceil : float -> float
val ceilf : float -> float
val ceill : LDouble.t -> LDouble.t
val floor : float -> float
val floorf : float -> float
val floorl : LDouble.t -> LDouble.t
val nearbyint : float -> float
val nearbyintf : float -> float
val nearbyintl : LDouble.t -> LDouble.t
val rint : float -> float
val rintf : float -> float
val rintl : LDouble.t -> LDouble.t
val lrint : float -> Signed.Long.t
val lrintf : float -> Signed.Long.t
val lrintl : LDouble.t -> Signed.Long.t
val llrint : float -> Signed.LLong.t
val llrintf : float -> Signed.LLong.t
val llrintl : LDouble.t -> Signed.LLong.t
val round : float -> float
val roundf : float -> float
val roundl : LDouble.t -> LDouble.t
val lround : float -> Signed.Long.t
val lroundf : float -> Signed.Long.t
val lroundl : LDouble.t -> Signed.Long.t
val llround : float -> Signed.LLong.t
val llroundf : float -> Signed.LLong.t
val llroundl : LDouble.t -> Signed.LLong.t
val trunc : float -> float
val truncf : float -> float
val truncl : LDouble.t -> LDouble.t

(** {1 Remainder Functions} *)

val fmod : float -> float -> float
val fmodf : float -> float -> float
val fmodl : LDouble.t -> LDouble.t -> LDouble.t
val remainder : float -> float -> float
val remainderf : float -> float -> float
val remainderl : LDouble.t -> LDouble.t -> LDouble.t
val remquo : float -> float -> int ptr -> float
val remquof : float -> float -> int ptr -> float
val remquol : LDouble.t -> LDouble.t -> int ptr -> LDouble.t

(** {1 Manipulation Functions} *)

val copysign : float -> float -> float
val copysignf : float -> float -> float
val copysignl : LDouble.t -> LDouble.t -> LDouble.t
val nan : string -> float
val nanf : string -> float
val nanl : string -> LDouble.t
val nextafter : float -> float -> float
val nextafterf : float -> float -> float
val nextafterl : LDouble.t -> LDouble.t -> LDouble.t
val nexttoward : float -> LDouble.t -> float
val nexttowardf : float -> LDouble.t -> float
val nexttowardl : LDouble.t -> LDouble.t -> LDouble.t

(** {1 Positive Difference and Multiply-Add} *)

val fdim : float -> float -> float
val fdimf : float -> float -> float
val fdiml : LDouble.t -> LDouble.t -> LDouble.t
val fma : float -> float -> float -> float
val fmaf : float -> float -> float -> float
val fmal : LDouble.t -> LDouble.t -> LDouble.t -> LDouble.t
val fmax : float -> float -> float
val fmaxf : float -> float -> float
val fmaxl : LDouble.t -> LDouble.t -> LDouble.t
val fmin : float -> float -> float
val fminf : float -> float -> float
val fminl : LDouble.t -> LDouble.t -> LDouble.t

(** {1 Bessel Functions} *)

val j0 : float -> float
val j1 : float -> float
val jn : int -> float -> float
val y0 : float -> float
val y1 : float -> float
val yn : int -> float -> float
