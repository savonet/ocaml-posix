open Ctypes

(** Utilities modules to build ctypes bindings. *)

(** Module used to define stubs generators. See: {!Posix_uname_stubs} and
    {!Posix_uname_constants} For some examples. *)
module Generators : sig
  module type TypesDef = sig
    module Types : Cstubs.Types.BINDINGS

    val c_headers : string
  end

  module Types (_ : TypesDef) : sig
    val gen : unit -> unit
  end

  module type StubsDef = sig
    module Stubs : Cstubs.BINDINGS

    val c_headers : string
    val concurrency : Cstubs.concurrency_policy
    val prefix : string
  end

  module Stubs (_ : StubsDef) : sig
    val gen : unit -> unit
  end
end

(** Module used to define generic types using their size. See {!Posix_types} for
    an example. *)
module Types : sig
  (** Module type for signed integers. *)
  module type Signed = sig
    type t

    val t : t typ

    include Signed.S with type t := t
  end

  val mkSigned : name:string -> size:int -> (module Signed)

  (** Module type for unsigned integers. *)
  module type Unsigned = sig
    type t

    val t : t typ

    include Unsigned.S with type t := t
  end

  val mkUnsigned : name:string -> size:int -> (module Unsigned)

  (** Module type for arithmetic numbers. In POSIX world, an arithmetic type can
      be either a floating point number or an integer (of unknown size). *)
  module type Arithmetic = sig
    type t

    val t : t typ
    val is_float : bool
    val to_int64 : t -> int64
    val of_int64 : int64 -> t
    val to_float : t -> float
    val of_float : float -> t
  end

  val mkArithmetic :
    name:string -> size:int -> is_float:bool -> (module Arithmetic)
end
