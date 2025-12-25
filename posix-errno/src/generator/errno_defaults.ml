module System_detect = System_detect

(* Type for errno definition with platform-specific overrides *)
type errno_def = {
  name : string;
  default : int;
  overrides : (string list * int) list;
}

(* Unified errno definitions with default values and platform-specific overrides
   Default values are typically for Linux, with overrides for BSD/macOS and Windows *)
let errno_defs =
  [
    (* Standard POSIX errno values - consistent across platforms *)
    { name = "E2BIG"; default = 7; overrides = [] };
    { name = "EACCES"; default = 13; overrides = [] };
    { name = "EBADF"; default = 9; overrides = [] };
    { name = "EBUSY"; default = 16; overrides = [] };
    { name = "ECHILD"; default = 10; overrides = [] };
    { name = "EDOM"; default = 33; overrides = [] };
    { name = "EEXIST"; default = 17; overrides = [] };
    { name = "EFAULT"; default = 14; overrides = [] };
    { name = "EFBIG"; default = 27; overrides = [] };
    { name = "EINTR"; default = 4; overrides = [] };
    { name = "EINVAL"; default = 22; overrides = [] };
    { name = "EIO"; default = 5; overrides = [] };
    { name = "EISDIR"; default = 21; overrides = [] };
    { name = "EMFILE"; default = 24; overrides = [] };
    { name = "EMLINK"; default = 31; overrides = [] };
    { name = "ENFILE"; default = 23; overrides = [] };
    { name = "ENODEV"; default = 19; overrides = [] };
    { name = "ENOENT"; default = 2; overrides = [] };
    { name = "ENOEXEC"; default = 8; overrides = [] };
    { name = "ENOMEM"; default = 12; overrides = [] };
    { name = "ENOSPC"; default = 28; overrides = [] };
    { name = "ENOTDIR"; default = 20; overrides = [] };
    { name = "ENOTTY"; default = 25; overrides = [] };
    { name = "ENXIO"; default = 6; overrides = [] };
    { name = "EPERM"; default = 1; overrides = [] };
    { name = "EPIPE"; default = 32; overrides = [] };
    { name = "ERANGE"; default = 34; overrides = [] };
    { name = "EROFS"; default = 30; overrides = [] };
    { name = "ESPIPE"; default = 29; overrides = [] };
    { name = "ESRCH"; default = 3; overrides = [] };
    { name = "EXDEV"; default = 18; overrides = [] };
    { name = "ENOTBLK"; default = 15; overrides = [] };
    {
      name = "ETXTBSY";
      default = 26;
      overrides = [(["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 139)];
    };
    (* Network and extended POSIX errors - vary by platform *)
    {
      name = "EADDRINUSE";
      default = 98;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 48);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 100);
        ];
    };
    {
      name = "EADDRNOTAVAIL";
      default = 99;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 49);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 101);
        ];
    };
    {
      name = "EAFNOSUPPORT";
      default = 97;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 47);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 102);
        ];
    };
    {
      name = "EAGAIN";
      default = 11;
      overrides =
        [(["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 35)];
    };
    {
      name = "EALREADY";
      default = 114;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 37);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 103);
        ];
    };
    {
      name = "EBADMSG";
      default = 74;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 94);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 104);
        ];
    };
    {
      name = "ECANCELED";
      default = 125;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 89);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 105);
        ];
    };
    {
      name = "ECONNABORTED";
      default = 103;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 53);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 106);
        ];
    };
    {
      name = "ECONNREFUSED";
      default = 111;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 61);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 107);
        ];
    };
    {
      name = "ECONNRESET";
      default = 104;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 54);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 108);
        ];
    };
    {
      name = "EDEADLK";
      default = 35;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 11);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 36);
        ];
    };
    {
      name = "EDESTADDRREQ";
      default = 89;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 39);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 109);
        ];
    };
    {
      name = "EDQUOT";
      default = 122;
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
            69 );
        ];
    };
    {
      name = "EHOSTDOWN";
      default = 112;
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
            64 );
        ];
    };
    {
      name = "EHOSTUNREACH";
      default = 113;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 65);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 110);
        ];
    };
    {
      name = "EIDRM";
      default = 43;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 90);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 111);
        ];
    };
    {
      name = "EILSEQ";
      default = 84;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 92);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 42);
        ];
    };
    {
      name = "EINPROGRESS";
      default = 115;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 36);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 112);
        ];
    };
    {
      name = "EISCONN";
      default = 106;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 56);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 113);
        ];
    };
    {
      name = "ELOOP";
      default = 40;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 62);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 114);
        ];
    };
    {
      name = "EMSGSIZE";
      default = 90;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 40);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 115);
        ];
    };
    {
      name = "EMULTIHOP";
      default = 72;
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
            95 );
        ];
    };
    {
      name = "ENAMETOOLONG";
      default = 36;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 63);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 38);
        ];
    };
    {
      name = "ENETDOWN";
      default = 100;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 50);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 116);
        ];
    };
    {
      name = "ENETRESET";
      default = 102;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 52);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 117);
        ];
    };
    {
      name = "ENETUNREACH";
      default = 101;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 51);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 118);
        ];
    };
    {
      name = "ENOBUFS";
      default = 105;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 55);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 119);
        ];
    };
    {
      name = "ENODATA";
      default = 61;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 96);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 120);
        ];
    };
    {
      name = "ENOLCK";
      default = 37;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 77);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 39);
        ];
    };
    {
      name = "ENOLINK";
      default = 67;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 97);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 121);
        ];
    };
    {
      name = "ENOMSG";
      default = 42;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 91);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 122);
        ];
    };
    {
      name = "ENOPROTOOPT";
      default = 92;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 42);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 123);
        ];
    };
    {
      name = "ENOSR";
      default = 63;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 98);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 124);
        ];
    };
    {
      name = "ENOSTR";
      default = 60;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 99);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 125);
        ];
    };
    {
      name = "ENOSYS";
      default = 38;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 78);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 40);
        ];
    };
    {
      name = "ENOTCONN";
      default = 107;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 57);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 126);
        ];
    };
    {
      name = "ENOTEMPTY";
      default = 39;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 66);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 41);
        ];
    };
    {
      name = "ENOTRECOVERABLE";
      default = 131;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 104);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 127);
        ];
    };
    {
      name = "ENOTSOCK";
      default = 88;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 38);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 128);
        ];
    };
    {
      name = "ENOTSUP";
      default = 95;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 45);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 129);
        ];
    };
    {
      name = "EOPNOTSUPP";
      default = 95;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 102);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 130);
        ];
    };
    {
      name = "EOVERFLOW";
      default = 75;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 84);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 132);
        ];
    };
    {
      name = "EOWNERDEAD";
      default = 130;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 105);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 133);
        ];
    };
    {
      name = "EPFNOSUPPORT";
      default = 96;
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
            46 );
        ];
    };
    {
      name = "EPROTO";
      default = 71;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 100);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 134);
        ];
    };
    {
      name = "EPROTONOSUPPORT";
      default = 93;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 43);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 135);
        ];
    };
    {
      name = "EPROTOTYPE";
      default = 91;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 41);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 136);
        ];
    };
    {
      name = "EREMOTE";
      default = 66;
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
            71 );
        ];
    };
    {
      name = "ESHUTDOWN";
      default = 108;
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
            58 );
        ];
    };
    {
      name = "ESOCKTNOSUPPORT";
      default = 94;
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
            44 );
        ];
    };
    {
      name = "ESTALE";
      default = 116;
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
            70 );
        ];
    };
    {
      name = "ETIME";
      default = 62;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 101);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 137);
        ];
    };
    {
      name = "ETIMEDOUT";
      default = 110;
      overrides =
        [
          (["macosx"; "freebsd"; "openbsd"; "netbsd"; "dragonfly"], 60);
          (["win32"; "win64"; "cygwin"; "mingw"; "mingw64"], 138);
        ];
    };
    {
      name = "ETOOMANYREFS";
      default = 109;
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
            59 );
        ];
    };
    {
      name = "EUSERS";
      default = 87;
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
            68 );
        ];
    };
    (* Linux-specific errors - use high placeholder values on other platforms *)
    {
      name = "EBADE";
      default = 52;
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
            10052 );
        ];
    };
    {
      name = "EBADFD";
      default = 77;
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
            10077 );
        ];
    };
    {
      name = "EBADR";
      default = 53;
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
            10053 );
        ];
    };
    {
      name = "EBADRQC";
      default = 56;
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
            10056 );
        ];
    };
    {
      name = "EBADSLT";
      default = 57;
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
            10057 );
        ];
    };
    {
      name = "ECHRNG";
      default = 44;
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
            10044 );
        ];
    };
    {
      name = "ECOMM";
      default = 70;
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
            10070 );
        ];
    };
    {
      name = "EHWPOISON";
      default = 133;
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
            10133 );
        ];
    };
    {
      name = "EISNAM";
      default = 120;
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
            10120 );
        ];
    };
    {
      name = "EKEYEXPIRED";
      default = 127;
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
            10127 );
        ];
    };
    {
      name = "EKEYREJECTED";
      default = 129;
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
            10129 );
        ];
    };
    {
      name = "EKEYREVOKED";
      default = 128;
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
            10128 );
        ];
    };
    {
      name = "EL2HLT";
      default = 51;
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
            10051 );
        ];
    };
    {
      name = "EL2NSYNC";
      default = 45;
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
            10045 );
        ];
    };
    {
      name = "EL3HLT";
      default = 46;
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
            10046 );
        ];
    };
    {
      name = "EL3RST";
      default = 47;
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
            10047 );
        ];
    };
    {
      name = "ELIBACC";
      default = 79;
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
            10079 );
        ];
    };
    {
      name = "ELIBBAD";
      default = 80;
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
            10080 );
        ];
    };
    {
      name = "ELIBEXEC";
      default = 83;
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
            10083 );
        ];
    };
    {
      name = "ELIBMAX";
      default = 82;
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
            10082 );
        ];
    };
    {
      name = "ELIBSCN";
      default = 81;
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
            10081 );
        ];
    };
    {
      name = "ELNRNG";
      default = 48;
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
            10048 );
        ];
    };
    {
      name = "EMEDIUMTYPE";
      default = 124;
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
            10124 );
        ];
    };
    {
      name = "ENOANO";
      default = 55;
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
            10055 );
        ];
    };
    {
      name = "ENOKEY";
      default = 126;
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
            10126 );
        ];
    };
    {
      name = "ENOMEDIUM";
      default = 123;
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
            10123 );
        ];
    };
    {
      name = "ENONET";
      default = 64;
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
            10064 );
        ];
    };
    {
      name = "ENOPKG";
      default = 65;
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
            10065 );
        ];
    };
    {
      name = "ENOTUNIQ";
      default = 76;
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
            10076 );
        ];
    };
    {
      name = "EREMCHG";
      default = 78;
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
            10078 );
        ];
    };
    {
      name = "EREMOTEIO";
      default = 121;
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
            10121 );
        ];
    };
    {
      name = "ERESTART";
      default = 85;
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
            10085 );
        ];
    };
    {
      name = "ERFKILL";
      default = 132;
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
            10132 );
        ];
    };
    {
      name = "ESTRPIPE";
      default = 86;
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
            10086 );
        ];
    };
    {
      name = "ETOOBIG";
      default = 200;
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
            10200 );
        ];
    };
    {
      name = "EUCLEAN";
      default = 117;
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
            10117 );
        ];
    };
    {
      name = "EUNATCH";
      default = 49;
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
            10049 );
        ];
    };
    {
      name = "EXFULL";
      default = 54;
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
            10054 );
        ];
    };
    (* BSD/macOS-specific errors - use high placeholder values on Linux/Windows *)
    {
      name = "EAUTH";
      default = 10080;
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
            80 );
        ];
    };
    {
      name = "EBADRPC";
      default = 10072;
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
            72 );
        ];
    };
    {
      name = "EFTYPE";
      default = 10079;
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
            79 );
        ];
    };
    {
      name = "ENEEDAUTH";
      default = 10081;
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
            81 );
        ];
    };
    { name = "ENOCSI"; default = 50; overrides = [] };
    {
      name = "EPROCLIM";
      default = 10067;
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
            67 );
        ];
    };
    {
      name = "EPROCUNAVAIL";
      default = 10076;
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
            76 );
        ];
    };
    {
      name = "EPROGMISMATCH";
      default = 10075;
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
            75 );
        ];
    };
    {
      name = "EPROGUNAVAIL";
      default = 10074;
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
            74 );
        ];
    };
    {
      name = "ERPCMISMATCH";
      default = 10073;
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
            73 );
        ];
    };
    (* macOS-specific errors - use high placeholder values on Linux/Windows *)
    {
      name = "EATTR";
      default = 10093;
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
            93 );
        ];
    };
    {
      name = "EBADARCH";
      default = 10086;
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
            86 );
        ];
    };
    {
      name = "EBADEXEC";
      default = 10085;
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
            85 );
        ];
    };
    {
      name = "EBADMACHO";
      default = 10088;
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
            88 );
        ];
    };
    {
      name = "EDEVERR";
      default = 10083;
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
            83 );
        ];
    };
    {
      name = "ENOATTR";
      default = 10093;
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
            93 );
        ];
    };
    {
      name = "ENOPOLICY";
      default = 10103;
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
            103 );
        ];
    };
    {
      name = "EPWROFF";
      default = 10082;
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
            82 );
        ];
    };
    {
      name = "ESHLIBVERS";
      default = 10087;
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
            87 );
        ];
    };
    (* Cross-platform "other" error *)
    { name = "EOTHER"; default = 10000; overrides = [] };
  ]

(* Errno aliases - these reference other errno values *)
let errno_aliases = [("EWOULDBLOCK", "EAGAIN"); ("EDEADLOCK", "EDEADLK")]

(* Get the errno value for a given system *)
let get_value_for_system system errno_def =
  (* Check if any override matches the current system *)
  let rec find_override = function
    | [] -> errno_def.default
    | (systems, value) :: rest ->
        if List.mem system systems then value else find_override rest
  in
  find_override errno_def.overrides

(* Get platform-specific errno defaults based on system *)
let get_errno_defaults system =
  List.map (fun def -> (def.name, get_value_for_system system def)) errno_defs

(* Main errno defaults to use for this build *)
let errno_defaults = get_errno_defaults System_detect.system
