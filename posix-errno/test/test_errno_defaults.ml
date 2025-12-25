open Posix_errno

(* Function to get system errno value *)
let get_system_value = function
  | "E2BIG" -> to_int `E2BIG
  | "EACCES" -> to_int `EACCES
  | "EADDRINUSE" -> to_int `EADDRINUSE
  | "EADDRNOTAVAIL" -> to_int `EADDRNOTAVAIL
  | "EAFNOSUPPORT" -> to_int `EAFNOSUPPORT
  | "EAGAIN" -> to_int `EAGAIN
  | "EALREADY" -> to_int `EALREADY
  | "EBADF" -> to_int `EBADF
  | "EBADMSG" -> to_int `EBADMSG
  | "EBUSY" -> to_int `EBUSY
  | "ECANCELED" -> to_int `ECANCELED
  | "ECHILD" -> to_int `ECHILD
  | "ECONNABORTED" -> to_int `ECONNABORTED
  | "ECONNREFUSED" -> to_int `ECONNREFUSED
  | "ECONNRESET" -> to_int `ECONNRESET
  | "EDEADLK" -> to_int `EDEADLK
  | "EDESTADDRREQ" -> to_int `EDESTADDRREQ
  | "EDOM" -> to_int `EDOM
  | "EDQUOT" -> to_int `EDQUOT
  | "EEXIST" -> to_int `EEXIST
  | "EFAULT" -> to_int `EFAULT
  | "EFBIG" -> to_int `EFBIG
  | "EHOSTDOWN" -> to_int `EHOSTDOWN
  | "EHOSTUNREACH" -> to_int `EHOSTUNREACH
  | "EIDRM" -> to_int `EIDRM
  | "EILSEQ" -> to_int `EILSEQ
  | "EINPROGRESS" -> to_int `EINPROGRESS
  | "EINTR" -> to_int `EINTR
  | "EINVAL" -> to_int `EINVAL
  | "EIO" -> to_int `EIO
  | "EISCONN" -> to_int `EISCONN
  | "EISDIR" -> to_int `EISDIR
  | "ELOOP" -> to_int `ELOOP
  | "EMFILE" -> to_int `EMFILE
  | "EMLINK" -> to_int `EMLINK
  | "EMSGSIZE" -> to_int `EMSGSIZE
  | "EMULTIHOP" -> to_int `EMULTIHOP
  | "ENAMETOOLONG" -> to_int `ENAMETOOLONG
  | "ENETDOWN" -> to_int `ENETDOWN
  | "ENETRESET" -> to_int `ENETRESET
  | "ENETUNREACH" -> to_int `ENETUNREACH
  | "ENFILE" -> to_int `ENFILE
  | "ENOBUFS" -> to_int `ENOBUFS
  | "ENODATA" -> to_int `ENODATA
  | "ENODEV" -> to_int `ENODEV
  | "ENOENT" -> to_int `ENOENT
  | "ENOEXEC" -> to_int `ENOEXEC
  | "ENOLCK" -> to_int `ENOLCK
  | "ENOLINK" -> to_int `ENOLINK
  | "ENOMEM" -> to_int `ENOMEM
  | "ENOMSG" -> to_int `ENOMSG
  | "ENOPROTOOPT" -> to_int `ENOPROTOOPT
  | "ENOSPC" -> to_int `ENOSPC
  | "ENOSR" -> to_int `ENOSR
  | "ENOSTR" -> to_int `ENOSTR
  | "ENOSYS" -> to_int `ENOSYS
  | "ENOTCONN" -> to_int `ENOTCONN
  | "ENOTDIR" -> to_int `ENOTDIR
  | "ENOTEMPTY" -> to_int `ENOTEMPTY
  | "ENOTRECOVERABLE" -> to_int `ENOTRECOVERABLE
  | "ENOTSOCK" -> to_int `ENOTSOCK
  | "ENOTSUP" -> to_int `ENOTSUP
  | "ENOTTY" -> to_int `ENOTTY
  | "ENXIO" -> to_int `ENXIO
  | "EOPNOTSUPP" -> to_int `EOPNOTSUPP
  | "EOVERFLOW" -> to_int `EOVERFLOW
  | "EOWNERDEAD" -> to_int `EOWNERDEAD
  | "EPERM" -> to_int `EPERM
  | "EPFNOSUPPORT" -> to_int `EPFNOSUPPORT
  | "EPIPE" -> to_int `EPIPE
  | "EPROTO" -> to_int `EPROTO
  | "EPROTONOSUPPORT" -> to_int `EPROTONOSUPPORT
  | "EPROTOTYPE" -> to_int `EPROTOTYPE
  | "ERANGE" -> to_int `ERANGE
  | "EREMOTE" -> to_int `EREMOTE
  | "EROFS" -> to_int `EROFS
  | "ESHUTDOWN" -> to_int `ESHUTDOWN
  | "ESOCKTNOSUPPORT" -> to_int `ESOCKTNOSUPPORT
  | "ESPIPE" -> to_int `ESPIPE
  | "ESRCH" -> to_int `ESRCH
  | "ESTALE" -> to_int `ESTALE
  | "ETIME" -> to_int `ETIME
  | "ETIMEDOUT" -> to_int `ETIMEDOUT
  | "ETOOMANYREFS" -> to_int `ETOOMANYREFS
  | "ETXTBSY" -> to_int `ETXTBSY
  | "EUSERS" -> to_int `EUSERS
  | "EXDEV" -> to_int `EXDEV
  (* Linux-specific *)
  | "EBADE" -> to_int `EBADE
  | "EBADFD" -> to_int `EBADFD
  | "EBADR" -> to_int `EBADR
  | "EBADRQC" -> to_int `EBADRQC
  | "EBADSLT" -> to_int `EBADSLT
  | "ECHRNG" -> to_int `ECHRNG
  | "ECOMM" -> to_int `ECOMM
  | "EHWPOISON" -> to_int `EHWPOISON
  | "EISNAM" -> to_int `EISNAM
  | "EKEYEXPIRED" -> to_int `EKEYEXPIRED
  | "EKEYREJECTED" -> to_int `EKEYREJECTED
  | "EKEYREVOKED" -> to_int `EKEYREVOKED
  | "EL2HLT" -> to_int `EL2HLT
  | "EL2NSYNC" -> to_int `EL2NSYNC
  | "EL3HLT" -> to_int `EL3HLT
  | "EL3RST" -> to_int `EL3RST
  | "ELIBACC" -> to_int `ELIBACC
  | "ELIBBAD" -> to_int `ELIBBAD
  | "ELIBEXEC" -> to_int `ELIBEXEC
  | "ELIBMAX" -> to_int `ELIBMAX
  | "ELIBSCN" -> to_int `ELIBSCN
  | "ELNRNG" -> to_int `ELNRNG
  | "EMEDIUMTYPE" -> to_int `EMEDIUMTYPE
  | "ENOANO" -> to_int `ENOANO
  | "ENOKEY" -> to_int `ENOKEY
  | "ENOMEDIUM" -> to_int `ENOMEDIUM
  | "ENONET" -> to_int `ENONET
  | "ENOPKG" -> to_int `ENOPKG
  | "ENOTBLK" -> to_int `ENOTBLK
  | "ENOTUNIQ" -> to_int `ENOTUNIQ
  | "EREMCHG" -> to_int `EREMCHG
  | "EREMOTEIO" -> to_int `EREMOTEIO
  | "ERESTART" -> to_int `ERESTART
  | "ERFKILL" -> to_int `ERFKILL
  | "ESTRPIPE" -> to_int `ESTRPIPE
  | "ETOOBIG" -> to_int `ETOOBIG
  | "EUCLEAN" -> to_int `EUCLEAN
  | "EUNATCH" -> to_int `EUNATCH
  | "EXFULL" -> to_int `EXFULL
  (* BSD/macOS *)
  | "EAUTH" -> to_int `EAUTH
  | "EBADRPC" -> to_int `EBADRPC
  | "EFTYPE" -> to_int `EFTYPE
  | "ENEEDAUTH" -> to_int `ENEEDAUTH
  | "ENOCSI" -> to_int `ENOCSI
  | "EPROCLIM" -> to_int `EPROCLIM
  | "EPROCUNAVAIL" -> to_int `EPROCUNAVAIL
  | "EPROGMISMATCH" -> to_int `EPROGMISMATCH
  | "EPROGUNAVAIL" -> to_int `EPROGUNAVAIL
  | "ERPCMISMATCH" -> to_int `ERPCMISMATCH
  (* macOS *)
  | "EATTR" -> to_int `EATTR
  | "EBADARCH" -> to_int `EBADARCH
  | "EBADEXEC" -> to_int `EBADEXEC
  | "EBADMACHO" -> to_int `EBADMACHO
  | "EDEVERR" -> to_int `EDEVERR
  | "ENOATTR" -> to_int `ENOATTR
  | "ENOPOLICY" -> to_int `ENOPOLICY
  | "EPWROFF" -> to_int `EPWROFF
  | "ESHLIBVERS" -> to_int `ESHLIBVERS
  (* Windows *)
  | "EOTHER" -> to_int `EOTHER
  | _ -> failwith "Unknown errno"

let get_alias_value _name target_name =
  try get_system_value target_name
  with _ ->
    Printf.printf "    (alias target %s not found)\n" target_name;
    -1

let () =
  Printf.printf "=== POSIX Errno Default Values Test ===\n\n";

  (* Print system information *)
  Printf.printf "Platform: system=%s\n\n" Errno_defaults.System_detect.system;

  Printf.printf "Comparing default errno values with system values...\n\n";

  (* Compare regular errno values *)
  Printf.printf "Regular errno constants:\n";
  Printf.printf "%-20s | %-10s | %-10s | %s\n" "Name" "Default" "System"
    "Status";
  Printf.printf "%s\n" (String.make 65 '-');

  let matching = ref 0 in
  let different = ref 0 in
  let different_list = ref [] in

  List.iter
    (fun (name, default_value) ->
      let system_value = get_system_value name in
      let status, mark =
        if system_value = default_value then (
          incr matching;
          ("MATCH", "  "))
        else (
          incr different;
          different_list :=
            (name, default_value, system_value) :: !different_list;
          ("DIFFERENT", "**"))
      in
      Printf.printf "%s%-20s | %-10d | %-10d | %s\n" mark name default_value
        system_value status)
    Errno_defaults.errno_defaults;

  (* Handle aliases *)
  Printf.printf "\nErrno aliases:\n";
  Printf.printf "%-20s | %-15s | %-10s\n" "Alias" "Target" "Value";
  Printf.printf "%s\n" (String.make 50 '-');

  List.iter
    (fun (alias_name, target_name) ->
      let value = get_alias_value alias_name target_name in
      if value >= 0 then
        Printf.printf "  %-20s | %-15s | %-10d\n" alias_name target_name value)
    Errno_defaults.errno_aliases;

  (* Summary *)
  Printf.printf "\n=== Summary ===\n";
  Printf.printf "Total errno constants tested: %d\n"
    (List.length Errno_defaults.errno_defaults);
  Printf.printf "Values matching defaults: %d\n" !matching;
  Printf.printf "Values different from defaults: %d\n" !different;

  if !different > 0 then (
    Printf.printf "\nValues that differ from defaults:\n";
    List.iter
      (fun (name, default_val, system_val) ->
        Printf.printf "  %-20s: default=%d, system=%d (diff=%d)\n" name
          default_val system_val (system_val - default_val))
      (List.rev !different_list));

  Printf.printf "\nNote: Values that match the defaults may either:\n";
  Printf.printf "  1. Be natively defined by the system with that value, OR\n";
  Printf.printf
    "  2. Not be defined by the system and use the fallback default value\n";
  Printf.printf
    "\nValues that differ from defaults are definitely defined by the system.\n";

  Printf.printf
    "\nTest completed successfully (informational only, no failures)\n"
