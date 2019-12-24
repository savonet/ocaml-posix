open Ctypes

module Generators = struct
  module type TypesDef = sig
    module Types  : Cstubs.Types.BINDINGS
    val c_headers : string
  end

  module Types(Def: TypesDef) = struct
    let gen () =
      let fname = Sys.argv.(1) in
      let oc = open_out_bin fname in
      let format =
        Format.formatter_of_out_channel oc
      in
      Format.fprintf format "%s@\n" Def.c_headers;
      Cstubs.Types.write_c format (module Def.Types);
      Format.pp_print_flush format ();
      close_out oc
  end

  module type StubsDef = sig
    module Stubs    : Cstubs.BINDINGS
    val c_headers   : string
    val concurrency : Cstubs.concurrency_policy
    val prefix      : string
  end

  module Stubs(Def: StubsDef) = struct
    let gen () =
      let mode = Sys.argv.(1) in
      let fname = Sys.argv.(2) in
      let oc = open_out_bin fname in
      let format =
        Format.formatter_of_out_channel oc
      in
      let fn =
        match mode with
          | "ml" -> Cstubs.write_ml
          | "c"  ->
             Format.fprintf format "%s@\n" Def.c_headers;
             Cstubs.write_c
          | _    -> assert false
      in
      fn ~concurrency:Def.concurrency format ~prefix:Def.prefix (module Def.Stubs);
      Format.pp_print_flush format ();
      close_out oc
  end
end

module Types = struct
  module type Signed = sig
    type t
    val t : t typ
    include Signed.S with type t := t
  end

  module Int8 = struct
   let t = int8_t
   include Signed.Int
  end

  module Int16 = struct
   let t = int16_t
   include Signed.Int
  end

  module Int32 = struct
   let t = int32_t
   include Signed.Int32
  end

  module Int64 = struct
   let t = int64_t
   include Signed.Int64
  end

  let mkSigned ~name ~size : (module Signed) =
      match size with
        | 1 ->  (module struct
                   include Int8
                   let t = typedef t name
                 end)
        | 2 ->  (module struct
                   include Int16
                   let t = typedef t name
                 end)
        | 4 ->  (module struct
                   include Int32
                   let t = typedef t name
                 end)
        | 8 ->  (module struct
                   include Int64
                   let t = typedef t name
                 end)
        | _ -> assert false

  module type Unsigned = sig
    type t
    val t: t typ
    include Unsigned.S with type t := t
  end

  module UInt8 = struct
   let t = uint8_t
   include Unsigned.UInt8
  end

  module UInt16 = struct
   let t = uint16_t
   include Unsigned.UInt16
  end

  module UInt32 = struct
   let t = uint32_t
   include Unsigned.UInt32
  end

  module UInt64 = struct
   let t = uint64_t
   include Unsigned.UInt64
  end

  let mkUnsigned ~name ~size : (module Unsigned) =
      match size with
        | 1 ->  (module struct
                   include UInt8
                   let t = typedef t name
                 end)
        | 2 ->  (module struct
                   include UInt16
                   let t = typedef t name
                 end)
        | 4 ->  (module struct
                   include UInt32
                   let t = typedef t name
                 end)
        | 8 ->  (module struct
                   include UInt64
                   let t = typedef t name
                 end)
        | _ -> assert false
end
