(* Default errno values for platforms where they might not be defined *)
let errno_defaults =
  [
    (* Standard POSIX errno values - should be available everywhere *)
    ("E2BIG", 7);
    ("EACCES", 13);
    ("EADDRINUSE", 98);
    ("EADDRNOTAVAIL", 99);
    ("EAFNOSUPPORT", 97);
    ("EAGAIN", 11);
    ("EALREADY", 114);
    ("EBADF", 9);
    ("EBADMSG", 74);
    ("EBUSY", 16);
    ("ECANCELED", 125);
    ("ECHILD", 10);
    ("ECONNABORTED", 103);
    ("ECONNREFUSED", 111);
    ("ECONNRESET", 104);
    ("EDEADLK", 35);
    ("EDESTADDRREQ", 89);
    ("EDOM", 33);
    ("EDQUOT", 122);
    ("EEXIST", 17);
    ("EFAULT", 14);
    ("EFBIG", 27);
    ("EHOSTDOWN", 112);
    ("EHOSTUNREACH", 113);
    ("EIDRM", 43);
    ("EILSEQ", 84);
    ("EINPROGRESS", 115);
    ("EINTR", 4);
    ("EINVAL", 22);
    ("EIO", 5);
    ("EISCONN", 106);
    ("EISDIR", 21);
    ("ELOOP", 40);
    ("EMFILE", 24);
    ("EMLINK", 31);
    ("EMSGSIZE", 90);
    ("EMULTIHOP", 72);
    ("ENAMETOOLONG", 36);
    ("ENETDOWN", 100);
    ("ENETRESET", 102);
    ("ENETUNREACH", 101);
    ("ENFILE", 23);
    ("ENOBUFS", 105);
    ("ENODATA", 61);
    ("ENODEV", 19);
    ("ENOENT", 2);
    ("ENOEXEC", 8);
    ("ENOLCK", 37);
    ("ENOLINK", 67);
    ("ENOMEM", 12);
    ("ENOMSG", 42);
    ("ENOPROTOOPT", 92);
    ("ENOSPC", 28);
    ("ENOSR", 63);
    ("ENOSTR", 60);
    ("ENOSYS", 38);
    ("ENOTCONN", 107);
    ("ENOTDIR", 20);
    ("ENOTEMPTY", 39);
    ("ENOTRECOVERABLE", 131);
    ("ENOTSOCK", 88);
    ("ENOTSUP", 95);
    ("ENOTTY", 25);
    ("ENXIO", 6);
    ("EOPNOTSUPP", 95);
    ("EOVERFLOW", 75);
    ("EOWNERDEAD", 130);
    ("EPERM", 1);
    ("EPFNOSUPPORT", 96);
    ("EPIPE", 32);
    ("EPROTO", 71);
    ("EPROTONOSUPPORT", 93);
    ("EPROTOTYPE", 91);
    ("ERANGE", 34);
    ("EREMOTE", 66);
    ("EROFS", 30);
    ("ESHUTDOWN", 108);
    ("ESOCKTNOSUPPORT", 94);
    ("ESPIPE", 29);
    ("ESRCH", 3);
    ("ESTALE", 116);
    ("ETIME", 62);
    ("ETIMEDOUT", 110);
    ("ETOOMANYREFS", 109);
    ("ETXTBSY", 26);
    ("EUSERS", 87);
    ("EXDEV", 18);
    (* Linux-specific errno values *)
    ("EBADE", 52);
    ("EBADFD", 77);
    ("EBADR", 53);
    ("EBADRQC", 56);
    ("EBADSLT", 57);
    ("ECHRNG", 44);
    ("ECOMM", 70);
    ("EHWPOISON", 133);
    ("EISNAM", 120);
    ("EKEYEXPIRED", 127);
    ("EKEYREJECTED", 129);
    ("EKEYREVOKED", 128);
    ("EL2HLT", 51);
    ("EL2NSYNC", 45);
    ("EL3HLT", 46);
    ("EL3RST", 47);
    ("ELIBACC", 79);
    ("ELIBBAD", 80);
    ("ELIBEXEC", 83);
    ("ELIBMAX", 82);
    ("ELIBSCN", 81);
    ("ELNRNG", 48);
    ("EMEDIUMTYPE", 124);
    ("ENOANO", 55);
    ("ENOKEY", 126);
    ("ENOMEDIUM", 123);
    ("ENONET", 64);
    ("ENOPKG", 65);
    ("ENOTBLK", 15);
    ("ENOTUNIQ", 76);
    ("EREMCHG", 78);
    ("EREMOTEIO", 121);
    ("ERESTART", 85);
    ("ERFKILL", 132);
    ("ESTRPIPE", 86);
    ("ETOOBIG", 200);
    ("EUCLEAN", 117);
    ("EUNATCH", 49);
    ("EXFULL", 54);
    (* BSD/macOS-specific errno values *)
    ("EAUTH", 80);
    ("EBADRPC", 72);
    ("EFTYPE", 79);
    ("ENEEDAUTH", 81);
    ("ENOCSI", 50);
    ("EPROCLIM", 67);
    ("EPROCUNAVAIL", 76);
    ("EPROGMISMATCH", 75);
    ("EPROGUNAVAIL", 74);
    ("ERPCMISMATCH", 73);
    (* macOS-specific errno values *)
    ("EATTR", 93);
    ("EBADARCH", 86);
    ("EBADEXEC", 85);
    ("EBADMACHO", 88);
    ("EDEVERR", 83);
    ("ENOATTR", 93);
    ("ENOPOLICY", 103);
    ("EPWROFF", 82);
    ("ESHLIBVERS", 87);
    (* Windows-specific (MinGW) *)
    ("EOTHER", 10000);
  ]

(* Special cases that reference other values *)
let errno_aliases = [("EWOULDBLOCK", "EAGAIN"); ("EDEADLOCK", "EDEADLK")]

let generate_errno_defaults () =
  let regular_defs =
    List.map
      (fun (name, value) ->
        Printf.sprintf "#ifndef %s\n#define %s %d\n#endif\n" name name value)
      errno_defaults
  in
  let alias_defs =
    List.map
      (fun (name, alias) ->
        Printf.sprintf "#ifndef %s\n#define %s %s\n#endif\n" name name alias)
      errno_aliases
  in
  String.concat "\n" (regular_defs @ alias_defs)

module Constants = Posix_base.Generators.Types (struct
  module Types = Posix_errno_constants.Def

  let c_headers =
    Printf.sprintf
      {|
#include <errno.h>

/* Provide default values for errno constants that might not be defined on all platforms */

%s
|}
      (generate_errno_defaults ())
end)

let () = Constants.gen ()
