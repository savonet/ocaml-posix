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
