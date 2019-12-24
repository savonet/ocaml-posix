open Ctypes

module Generators : sig
  module type TypesDef = sig
    module Types  : Cstubs.Types.BINDINGS
    val c_headers : string
  end

  module Types(Def: TypesDef) : sig
    val gen : unit -> unit
  end

  module type StubsDef = sig
    module Stubs    : Cstubs.BINDINGS
    val c_headers   : string
    val concurrency : Cstubs.concurrency_policy
    val prefix      : string
  end

  module Stubs(Def: StubsDef) : sig
    val gen : unit -> unit
  end
end

module Types : sig
  module type Signed = sig
    type t
    val t: t typ
    include Signed.S with type t := t
  end

  val mkSigned: name:string -> size:int -> (module Signed)

  module type Unsigned = sig
    type t
    val t: t typ
    include Unsigned.S with type t := t
  end

  val mkUnsigned: name:string -> size:int -> (module Unsigned)
end
