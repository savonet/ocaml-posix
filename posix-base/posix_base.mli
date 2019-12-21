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
