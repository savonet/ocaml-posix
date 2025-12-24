module C = Configurator.V1

let () =
  C.main ~name:"posix-time2" (fun c ->
      let system = C.ocaml_config_var_exn c "system" in
      let c_library_flags =
        match system with
        | "mingw" | "mingw64" | "win32" | "win64" ->
            (* MinGW needs winpthread for clock functions and ws2_32 for select *)
            ["-lwinpthread"; "-lws2_32"]
        | _ -> []
      in
      C.Flags.write_sexp "c_library_flags.sexp" c_library_flags;
      C.Flags.write_sexp "c_flags.sexp" [])
