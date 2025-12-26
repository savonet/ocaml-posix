type eai_errno_def = {
  name : string;
  default : int;
  overrides : (string list * int) list;
}

let eai_errno_defs =
  [
    { name = "ADDRFAMILY"; default = 1; overrides = [] };
    {
      name = "AGAIN";
      default = -3;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 2);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 11002);
        ];
    };
    {
      name = "BADFLAGS";
      default = -1;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 3);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 10022);
        ];
    };
    {
      name = "FAIL";
      default = -4;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 4);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 11003);
        ];
    };
    {
      name = "FAMILY";
      default = -6;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 5);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 10047);
        ];
    };
    {
      name = "MEMORY";
      default = -10;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 6);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 8);
        ];
    };
    {
      name = "NODATA";
      default = 7;
      overrides = [(["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 11004)];
    };
    {
      name = "NONAME";
      default = -2;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 8);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 11001);
        ];
    };
    {
      name = "SERVICE";
      default = -8;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 9);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 10109);
        ];
    };
    {
      name = "SOCKTYPE";
      default = -7;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 10);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 10044);
        ];
    };
    {
      name = "SYSTEM";
      default = -11;
      overrides =
        [
          ( [
              "macosx";
              "freebsd";
              "openbsd";
              "netbsd";
              "dragonfly";
              "win32";
              "win64";
              "cygwin";
              "mingw";
              "mingw64";
            ],
            11 );
        ];
    };
    { name = "BADHINTS"; default = 12; overrides = [] };
    { name = "PROTOCOL"; default = 13; overrides = [] };
    {
      name = "OVERFLOW";
      default = -12;
      overrides =
        [
          ( [
              "macosx";
              "freebsd";
              "openbsd";
              "netbsd";
              "dragonfly";
              "win32";
              "win64";
              "cygwin";
              "mingw";
              "mingw64";
            ],
            14 );
        ];
    };
  ]

(* Get the eai_errno value for a given system *)
let get_value_for_system system eai_errno_def =
  (* Check if any override matches the current system *)
  let rec find_override = function
    | [] -> eai_errno_def.default
    | (systems, value) :: rest ->
        if List.mem system systems then value else find_override rest
  in
  find_override eai_errno_def.overrides

(* Get platform-specific eai_errno defaults based on system *)
let get_eai_errno_defaults system =
  List.map
    (fun def -> (def.name, get_value_for_system system def))
    eai_errno_defs

(* Main eai_errno defaults to use for this build *)
let eai_errno_defaults = get_eai_errno_defaults Posix_base.System_detect.system
