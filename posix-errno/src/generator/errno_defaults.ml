module System_detect = System_detect

(* Standard POSIX errno values that are consistent across platforms *)
let errno_defaults_common =
  [
    ("E2BIG", 7);
    ("EACCES", 13);
    ("EBADF", 9);
    ("EBUSY", 16);
    ("ECHILD", 10);
    ("EDOM", 33);
    ("EEXIST", 17);
    ("EFAULT", 14);
    ("EFBIG", 27);
    ("EINTR", 4);
    ("EINVAL", 22);
    ("EIO", 5);
    ("EISDIR", 21);
    ("EMFILE", 24);
    ("EMLINK", 31);
    ("ENFILE", 23);
    ("ENODEV", 19);
    ("ENOENT", 2);
    ("ENOEXEC", 8);
    ("ENOMEM", 12);
    ("ENOSPC", 28);
    ("ENOTDIR", 20);
    ("ENOTTY", 25);
    ("ENXIO", 6);
    ("EPERM", 1);
    ("EPIPE", 32);
    ("ERANGE", 34);
    ("EROFS", 30);
    ("ESPIPE", 29);
    ("ESRCH", 3);
    ("EXDEV", 18);
  ]

(* Linux-specific errno values *)
let errno_defaults_linux =
  [
    ("EADDRINUSE", 98);
    ("EADDRNOTAVAIL", 99);
    ("EAFNOSUPPORT", 97);
    ("EAGAIN", 11);
    ("EALREADY", 114);
    ("EBADMSG", 74);
    ("ECANCELED", 125);
    ("ECONNABORTED", 103);
    ("ECONNREFUSED", 111);
    ("ECONNRESET", 104);
    ("EDEADLK", 35);
    ("EDESTADDRREQ", 89);
    ("EDQUOT", 122);
    ("EHOSTDOWN", 112);
    ("EHOSTUNREACH", 113);
    ("EIDRM", 43);
    ("EILSEQ", 84);
    ("EINPROGRESS", 115);
    ("EISCONN", 106);
    ("ELOOP", 40);
    ("EMSGSIZE", 90);
    ("EMULTIHOP", 72);
    ("ENAMETOOLONG", 36);
    ("ENETDOWN", 100);
    ("ENETRESET", 102);
    ("ENETUNREACH", 101);
    ("ENOBUFS", 105);
    ("ENODATA", 61);
    ("ENOLCK", 37);
    ("ENOLINK", 67);
    ("ENOMSG", 42);
    ("ENOPROTOOPT", 92);
    ("ENOSR", 63);
    ("ENOSTR", 60);
    ("ENOSYS", 38);
    ("ENOTBLK", 15);
    ("ENOTCONN", 107);
    ("ENOTEMPTY", 39);
    ("ENOTRECOVERABLE", 131);
    ("ENOTSOCK", 88);
    ("ENOTSUP", 95);
    ("EOPNOTSUPP", 95);
    ("EOVERFLOW", 75);
    ("EOWNERDEAD", 130);
    ("EPFNOSUPPORT", 96);
    ("EPROTO", 71);
    ("EPROTONOSUPPORT", 93);
    ("EPROTOTYPE", 91);
    ("EREMOTE", 66);
    ("ESHUTDOWN", 108);
    ("ESOCKTNOSUPPORT", 94);
    ("ESTALE", 116);
    ("ETIME", 62);
    ("ETIMEDOUT", 110);
    ("ETOOMANYREFS", 109);
    ("ETXTBSY", 26);
    ("EUSERS", 87);
    (* Linux-specific errors *)
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
    ("ENOCSI", 50);
    ("EOTHER", 10000);
    (* Placeholders for BSD/macOS-only errors (use high values unlikely to conflict) *)
    ("EAUTH", 10080);
    ("EBADRPC", 10072);
    ("EFTYPE", 10079);
    ("ENEEDAUTH", 10081);
    ("EPROCLIM", 10067);
    ("EPROCUNAVAIL", 10076);
    ("EPROGMISMATCH", 10075);
    ("EPROGUNAVAIL", 10074);
    ("ERPCMISMATCH", 10073);
    ("EATTR", 10093);
    ("EBADARCH", 10086);
    ("EBADEXEC", 10085);
    ("EBADMACHO", 10088);
    ("EDEVERR", 10083);
    ("ENOATTR", 10093);
    ("ENOPOLICY", 10103);
    ("EPWROFF", 10082);
    ("ESHLIBVERS", 10087);
  ]

(* macOS/BSD-specific errno values
   Note: macOS, FreeBSD, OpenBSD, and NetBSD share similar errno numbering *)
let errno_defaults_bsd =
  [
    ("EADDRINUSE", 48);
    ("EADDRNOTAVAIL", 49);
    ("EAFNOSUPPORT", 47);
    ("EAGAIN", 35);
    ("EALREADY", 37);
    ("EBADMSG", 94);
    ("ECANCELED", 89);
    ("ECONNABORTED", 53);
    ("ECONNREFUSED", 61);
    ("ECONNRESET", 54);
    ("EDEADLK", 11);
    ("EDESTADDRREQ", 39);
    ("EDQUOT", 69);
    ("EHOSTDOWN", 64);
    ("EHOSTUNREACH", 65);
    ("EIDRM", 90);
    ("EILSEQ", 92);
    ("EINPROGRESS", 36);
    ("EISCONN", 56);
    ("ELOOP", 62);
    ("EMSGSIZE", 40);
    ("EMULTIHOP", 95);
    ("ENAMETOOLONG", 63);
    ("ENETDOWN", 50);
    ("ENETRESET", 52);
    ("ENETUNREACH", 51);
    ("ENOBUFS", 55);
    ("ENODATA", 96);
    ("ENOLCK", 77);
    ("ENOLINK", 97);
    ("ENOMSG", 91);
    ("ENOPROTOOPT", 42);
    ("ENOSR", 98);
    ("ENOSTR", 99);
    ("ENOSYS", 78);
    ("ENOTBLK", 15);
    ("ENOTCONN", 57);
    ("ENOTEMPTY", 66);
    ("ENOTRECOVERABLE", 104);
    ("ENOTSOCK", 38);
    ("ENOTSUP", 45);
    ("EOPNOTSUPP", 102);
    ("EOVERFLOW", 84);
    ("EOWNERDEAD", 105);
    ("EPFNOSUPPORT", 46);
    ("EPROTO", 100);
    ("EPROTONOSUPPORT", 43);
    ("EPROTOTYPE", 41);
    ("EREMOTE", 71);
    ("ESHUTDOWN", 58);
    ("ESOCKTNOSUPPORT", 44);
    ("ESTALE", 70);
    ("ETIME", 101);
    ("ETIMEDOUT", 60);
    ("ETOOMANYREFS", 59);
    ("ETXTBSY", 26);
    ("EUSERS", 68);
    (* BSD/macOS-specific errors *)
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
    (* macOS-specific errors *)
    ("EATTR", 93);
    ("EBADARCH", 86);
    ("EBADEXEC", 85);
    ("EBADMACHO", 88);
    ("EDEVERR", 83);
    ("ENOATTR", 93);
    ("ENOPOLICY", 103);
    ("EPWROFF", 82);
    ("ESHLIBVERS", 87);
    (* Placeholders for Linux-only (use high values unlikely to conflict) *)
    ("EBADE", 10052);
    ("EBADFD", 10077);
    ("EBADR", 10053);
    ("EBADRQC", 10056);
    ("EBADSLT", 10057);
    ("ECHRNG", 10044);
    ("ECOMM", 10070);
    ("EHWPOISON", 10133);
    ("EISNAM", 10120);
    ("EKEYEXPIRED", 10127);
    ("EKEYREJECTED", 10129);
    ("EKEYREVOKED", 10128);
    ("EL2HLT", 10051);
    ("EL2NSYNC", 10045);
    ("EL3HLT", 10046);
    ("EL3RST", 10047);
    ("ELIBACC", 10079);
    ("ELIBBAD", 10080);
    ("ELIBEXEC", 10083);
    ("ELIBMAX", 10082);
    ("ELIBSCN", 10081);
    ("ELNRNG", 10048);
    ("EMEDIUMTYPE", 10124);
    ("ENOANO", 10055);
    ("ENOKEY", 10126);
    ("ENOMEDIUM", 10123);
    ("ENONET", 10064);
    ("ENOPKG", 10065);
    ("ENOTUNIQ", 10076);
    ("EREMCHG", 10078);
    ("EREMOTEIO", 10121);
    ("ERESTART", 10085);
    ("ERFKILL", 10132);
    ("ESTRPIPE", 10086);
    ("ETOOBIG", 10200);
    ("EUCLEAN", 10117);
    ("EUNATCH", 10049);
    ("EXFULL", 10054);
    ("EOTHER", 10000);
  ]

(* Windows-specific errno values (MinGW) *)
let errno_defaults_windows =
  [
    (* Windows uses mostly the same values as the common set for basic errors *)
    (* Network errors on Windows *)
    ("EADDRINUSE", 100);
    ("EADDRNOTAVAIL", 101);
    ("EAFNOSUPPORT", 102);
    ("EAGAIN", 11);
    ("EALREADY", 103);
    ("EBADMSG", 104);
    ("ECANCELED", 105);
    ("ECONNABORTED", 106);
    ("ECONNREFUSED", 107);
    ("ECONNRESET", 108);
    ("EDEADLK", 36);
    ("EDESTADDRREQ", 109);
    ("EDQUOT", 69);
    ("EHOSTDOWN", 64);
    ("EHOSTUNREACH", 110);
    ("EIDRM", 111);
    ("EILSEQ", 42);
    ("EINPROGRESS", 112);
    ("EISCONN", 113);
    ("ELOOP", 114);
    ("EMSGSIZE", 115);
    ("EMULTIHOP", 95);
    ("ENAMETOOLONG", 38);
    ("ENETDOWN", 116);
    ("ENETRESET", 117);
    ("ENETUNREACH", 118);
    ("ENOBUFS", 119);
    ("ENODATA", 120);
    ("ENOLCK", 39);
    ("ENOLINK", 121);
    ("ENOMSG", 122);
    ("ENOPROTOOPT", 123);
    ("ENOSR", 124);
    ("ENOSTR", 125);
    ("ENOSYS", 40);
    ("ENOTBLK", 15);
    ("ENOTCONN", 126);
    ("ENOTEMPTY", 41);
    ("ENOTRECOVERABLE", 127);
    ("ENOTSOCK", 128);
    ("ENOTSUP", 129);
    ("EOPNOTSUPP", 130);
    ("EOVERFLOW", 132);
    ("EOWNERDEAD", 133);
    ("EPFNOSUPPORT", 46);
    ("EPROTO", 134);
    ("EPROTONOSUPPORT", 135);
    ("EPROTOTYPE", 136);
    ("EREMOTE", 71);
    ("ESHUTDOWN", 58);
    ("ESOCKTNOSUPPORT", 44);
    ("ESTALE", 70);
    ("ETIME", 137);
    ("ETIMEDOUT", 138);
    ("ETOOMANYREFS", 59);
    ("ETXTBSY", 139);
    ("EUSERS", 68);
    (* Windows-specific *)
    ("EOTHER", 10000);
    (* Placeholders for Linux-only errors *)
    ("EBADE", 10052);
    ("EBADFD", 10077);
    ("EBADR", 10053);
    ("EBADRQC", 10056);
    ("EBADSLT", 10057);
    ("ECHRNG", 10044);
    ("ECOMM", 10070);
    ("EHWPOISON", 10133);
    ("EISNAM", 10120);
    ("EKEYEXPIRED", 10127);
    ("EKEYREJECTED", 10129);
    ("EKEYREVOKED", 10128);
    ("EL2HLT", 10051);
    ("EL2NSYNC", 10045);
    ("EL3HLT", 10046);
    ("EL3RST", 10047);
    ("ELIBACC", 10079);
    ("ELIBBAD", 10080);
    ("ELIBEXEC", 10083);
    ("ELIBMAX", 10082);
    ("ELIBSCN", 10081);
    ("ELNRNG", 10048);
    ("EMEDIUMTYPE", 10124);
    ("ENOANO", 10055);
    ("ENOKEY", 10126);
    ("ENOMEDIUM", 10123);
    ("ENONET", 10064);
    ("ENOPKG", 10065);
    ("ENOTUNIQ", 10076);
    ("EREMCHG", 10078);
    ("EREMOTEIO", 10121);
    ("ERESTART", 10085);
    ("ERFKILL", 10132);
    ("ESTRPIPE", 10086);
    ("ETOOBIG", 10200);
    ("EUCLEAN", 10117);
    ("EUNATCH", 10049);
    ("EXFULL", 10054);
    (* BSD/macOS errors that are actually defined in MinGW *)
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
    ("EATTR", 93);
    ("EBADARCH", 86);
    ("EBADEXEC", 85);
    ("EBADMACHO", 88);
    ("EDEVERR", 83);
    ("ENOATTR", 93);
    ("ENOPOLICY", 103);
    ("EPWROFF", 82);
    ("ESHLIBVERS", 87);
  ]

(* Get platform-specific errno defaults based on build system *)
let get_platform_defaults () =
  if System_detect.os_type = "Win32" then (
    Printf.eprintf "Detected platform: windows (dune: %s, os_type: %s)\n%!"
      System_detect.system System_detect.os_type;
    errno_defaults_common @ errno_defaults_windows)
  else (
    match System_detect.system with
      | "macosx" | "freebsd" | "openbsd" | "netbsd" ->
          Printf.eprintf "Detected platform: bsd/%s (dune: %s, os_type: %s)\n%!"
            System_detect.system System_detect.system System_detect.os_type;
          errno_defaults_common @ errno_defaults_bsd
      | _ ->
          Printf.eprintf
            "Detected platform: linux or unknown (dune: %s, os_type: %s)\n%!"
            System_detect.system System_detect.os_type;
          errno_defaults_common @ errno_defaults_linux)

(* Main errno defaults to use *)
let errno_defaults = get_platform_defaults ()

(* Special cases that reference other values *)
let errno_aliases = [("EWOULDBLOCK", "EAGAIN"); ("EDEADLOCK", "EDEADLK")]
