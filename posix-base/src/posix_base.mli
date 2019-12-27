open Ctypes

module Generators : sig
  module type TypesDef = sig
    module Types : Cstubs.Types.BINDINGS

    val c_headers : string
  end

  module Types (Def : TypesDef) : sig
    val gen : unit -> unit
  end

  module type StubsDef = sig
    module Stubs : Cstubs.BINDINGS

    val c_headers : string
    val concurrency : Cstubs.concurrency_policy
    val prefix : string
  end

  module Stubs (Def : StubsDef) : sig
    val gen : unit -> unit
  end
end

module Types : sig
  module type Signed = sig
    type t

    val t : t typ

    include Signed.S with type t := t
  end

  val mkSigned : name:string -> size:int -> (module Signed)

  module type Unsigned = sig
    type t

    val t : t typ

    include Unsigned.S with type t := t
  end

  val mkUnsigned : name:string -> size:int -> (module Unsigned)

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
