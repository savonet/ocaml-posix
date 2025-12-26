open Ctypes

(* Errno C bindings *)
module Stubs = Posix_errno_stubs.Def (Posix_errno_generated_stubs)
include Posix_errno_type
include Posix_errno_conversions
include Posix_errno_is_native_impl

(** Get current errno value *)
let get_errno () = of_int (Stubs.posix_errno_get_errno ())

(** Get current errno as int *)
let get_errno_int () = Stubs.posix_errno_get_errno ()

(** Reset errno to 0 *)
let reset_errno () = Stubs.posix_errno_set_errno 0

(** Convert errno variant to Unix.error *)
let to_unix_error = function
  | `E2BIG -> Unix.E2BIG
  | `EACCES -> Unix.EACCES
  | `EAGAIN -> Unix.EAGAIN
  | `EBADF -> Unix.EBADF
  | `EBUSY -> Unix.EBUSY
  | `ECHILD -> Unix.ECHILD
  | `EDEADLK -> Unix.EDEADLK
  | `EDOM -> Unix.EDOM
  | `EEXIST -> Unix.EEXIST
  | `EFAULT -> Unix.EFAULT
  | `EFBIG -> Unix.EFBIG
  | `EINTR -> Unix.EINTR
  | `EINVAL -> Unix.EINVAL
  | `EIO -> Unix.EIO
  | `EISDIR -> Unix.EISDIR
  | `EMFILE -> Unix.EMFILE
  | `EMLINK -> Unix.EMLINK
  | `ENAMETOOLONG -> Unix.ENAMETOOLONG
  | `ENFILE -> Unix.ENFILE
  | `ENODEV -> Unix.ENODEV
  | `ENOENT -> Unix.ENOENT
  | `ENOEXEC -> Unix.ENOEXEC
  | `ENOLCK -> Unix.ENOLCK
  | `ENOMEM -> Unix.ENOMEM
  | `ENOSPC -> Unix.ENOSPC
  | `ENOSYS -> Unix.ENOSYS
  | `ENOTDIR -> Unix.ENOTDIR
  | `ENOTEMPTY -> Unix.ENOTEMPTY
  | `ENOTTY -> Unix.ENOTTY
  | `ENXIO -> Unix.ENXIO
  | `EPERM -> Unix.EPERM
  | `EPIPE -> Unix.EPIPE
  | `ERANGE -> Unix.ERANGE
  | `EROFS -> Unix.EROFS
  | `ESPIPE -> Unix.ESPIPE
  | `ESRCH -> Unix.ESRCH
  | `EXDEV -> Unix.EXDEV
  | `EWOULDBLOCK -> Unix.EWOULDBLOCK
  | `EINPROGRESS -> Unix.EINPROGRESS
  | `EALREADY -> Unix.EALREADY
  | `ENOTSOCK -> Unix.ENOTSOCK
  | `EDESTADDRREQ -> Unix.EDESTADDRREQ
  | `EMSGSIZE -> Unix.EMSGSIZE
  | `EPROTOTYPE -> Unix.EPROTOTYPE
  | `ENOPROTOOPT -> Unix.ENOPROTOOPT
  | `EPROTONOSUPPORT -> Unix.EPROTONOSUPPORT
  | `ESOCKTNOSUPPORT -> Unix.ESOCKTNOSUPPORT
  | `EOPNOTSUPP -> Unix.EOPNOTSUPP
  | `EPFNOSUPPORT -> Unix.EPFNOSUPPORT
  | `EAFNOSUPPORT -> Unix.EAFNOSUPPORT
  | `EADDRINUSE -> Unix.EADDRINUSE
  | `EADDRNOTAVAIL -> Unix.EADDRNOTAVAIL
  | `ENETDOWN -> Unix.ENETDOWN
  | `ENETUNREACH -> Unix.ENETUNREACH
  | `ENETRESET -> Unix.ENETRESET
  | `ECONNABORTED -> Unix.ECONNABORTED
  | `ECONNRESET -> Unix.ECONNRESET
  | `ENOBUFS -> Unix.ENOBUFS
  | `EISCONN -> Unix.EISCONN
  | `ENOTCONN -> Unix.ENOTCONN
  | `ESHUTDOWN -> Unix.ESHUTDOWN
  | `ETOOMANYREFS -> Unix.ETOOMANYREFS
  | `ETIMEDOUT -> Unix.ETIMEDOUT
  | `ECONNREFUSED -> Unix.ECONNREFUSED
  | `EHOSTDOWN -> Unix.EHOSTDOWN
  | `EHOSTUNREACH -> Unix.EHOSTUNREACH
  | `ELOOP -> Unix.ELOOP
  | `EOVERFLOW -> Unix.EOVERFLOW
  | ( `EATTR | `EAUTH | `EBADARCH | `EBADE | `EBADEXEC | `EBADFD | `EBADMACHO
    | `EBADMSG | `EBADR | `EBADRPC | `EBADRQC | `EBADSLT | `ECANCELED | `ECHRNG
    | `ECOMM | `EDEADLOCK | `EDEVERR | `EDQUOT | `EFTYPE | `EHWPOISON | `EIDRM
    | `EILSEQ | `EISNAM | `EKEYEXPIRED | `EKEYREJECTED | `EKEYREVOKED | `EL2HLT
    | `EL2NSYNC | `EL3HLT | `EL3RST | `ELIBACC | `ELIBBAD | `ELIBEXEC | `ELIBMAX
    | `ELIBSCN | `ELNRNG | `EMEDIUMTYPE | `EMULTIHOP | `ENEEDAUTH | `ENOANO
    | `ENOATTR | `ENOCSI | `ENODATA | `ENOKEY | `ENOLINK | `ENOMEDIUM | `ENOMSG
    | `ENONET | `ENOPKG | `ENOPOLICY | `ENOSR | `ENOSTR | `ENOTBLK
    | `ENOTRECOVERABLE | `ENOTSUP | `ENOTUNIQ | `EOTHER | `EOWNERDEAD
    | `EPROCLIM | `EPROCUNAVAIL | `EPROGMISMATCH | `EPROGUNAVAIL | `EPROTO
    | `EPWROFF | `EREMCHG | `EREMOTE | `EREMOTEIO | `ERESTART | `ERFKILL
    | `ERPCMISMATCH | `ESHLIBVERS | `ESTALE | `ESTRPIPE | `ETIME | `ETOOBIG
    | `ETXTBSY | `EUCLEAN | `EUNATCH | `EUSERS | `EXFULL ) as v ->
      Unix.EUNKNOWNERR (to_int v)
  | `EUNKNOWN n -> Unix.EUNKNOWNERR n

(** Convert errno int to Unix.error *)
let int_to_unix_error n = to_unix_error (of_int n)

(** Generic error-raising function *)
let raise_on_error ?(call = "") f check =
  reset_errno ();
  let result = f () in
  if check result then
    raise (Unix.Unix_error (to_unix_error (get_errno ()), call, ""))
  else result

(** Check for negative integer return *)
let raise_on_neg ?call f = raise_on_error ?call f (fun x -> x < 0)

(** Check for null pointer return *)
let raise_on_null ?call f = raise_on_error ?call f (fun ptr -> is_null ptr)

(** Check for zero return value *)
let raise_on_zero ?call f = raise_on_error ?call f (fun x -> x = 0)

let raise_on_none ?call f =
  Option.get (raise_on_error ?call f (fun x -> x = None))

let strerror err = Stubs.strerror (to_int err)

(** Get error string from errno using strerror_r (thread-safe, POSIX only)
    @raise Invalid_argument on Windows where strerror_r is not available *)
let strerror_r ?(buflen = 1024) err =
  let open Ctypes in
  let buf = CArray.make char buflen in
  let buf_ptr = CArray.start buf in
  let result = Stubs.strerror_r (to_int err) buf_ptr buflen in
  if result = 0 then (
    (* Success - get actual string length and convert to OCaml string *)
    let len = Stubs.strlen buf_ptr in
    string_from_ptr buf_ptr ~length:len)
  else (
    (* Error - strerror_r returned an error code, raise Unix error *)
    let err = int_to_unix_error result in
    raise (Unix.Unix_error (err, "strerror_r", "")))
