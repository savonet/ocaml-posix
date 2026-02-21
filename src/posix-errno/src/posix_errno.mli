(** POSIX errno handling *)

(** {1 Errno Type} *)

(** Comprehensive errno type covering Linux, BSD, macOS, and Windows values *)
type t =
  [ (* Standard POSIX *)
    `E2BIG
  | `EACCES
  | `EADDRINUSE
  | `EADDRNOTAVAIL
  | `EAFNOSUPPORT
  | `EAGAIN
  | `EALREADY
  | `EBADF
  | `EBADMSG
  | `EBUSY
  | `ECANCELED
  | `ECHILD
  | `ECONNABORTED
  | `ECONNREFUSED
  | `ECONNRESET
  | `EDEADLK
  | `EDESTADDRREQ
  | `EDOM
  | `EDQUOT
  | `EEXIST
  | `EFAULT
  | `EFBIG
  | `EHOSTDOWN
  | `EHOSTUNREACH
  | `EIDRM
  | `EILSEQ
  | `EINPROGRESS
  | `EINTR
  | `EINVAL
  | `EIO
  | `EISCONN
  | `EISDIR
  | `ELOOP
  | `EMFILE
  | `EMLINK
  | `EMSGSIZE
  | `EMULTIHOP
  | `ENAMETOOLONG
  | `ENETDOWN
  | `ENETRESET
  | `ENETUNREACH
  | `ENFILE
  | `ENOBUFS
  | `ENODATA
  | `ENODEV
  | `ENOENT
  | `ENOEXEC
  | `ENOLCK
  | `ENOLINK
  | `ENOMEM
  | `ENOMSG
  | `ENOPROTOOPT
  | `ENOSPC
  | `ENOSR
  | `ENOSTR
  | `ENOSYS
  | `ENOTCONN
  | `ENOTDIR
  | `ENOTEMPTY
  | `ENOTRECOVERABLE
  | `ENOTSOCK
  | `ENOTSUP
  | `ENOTTY
  | `ENXIO
  | `EOPNOTSUPP
  | `EOVERFLOW
  | `EOWNERDEAD
  | `EPERM
  | `EPFNOSUPPORT
  | `EPIPE
  | `EPROTO
  | `EPROTONOSUPPORT
  | `EPROTOTYPE
  | `ERANGE
  | `EREMOTE
  | `EROFS
  | `ESHUTDOWN
  | `ESOCKTNOSUPPORT
  | `ESPIPE
  | `ESRCH
  | `ESTALE
  | `ETIME
  | `ETIMEDOUT
  | `ETOOMANYREFS
  | `ETXTBSY
  | `EUSERS
  | `EWOULDBLOCK
  | `EXDEV
  | (* Linux-specific *)
    `EBADE
  | `EBADFD
  | `EBADR
  | `EBADRQC
  | `EBADSLT
  | `ECHRNG
  | `ECOMM
  | `EDEADLOCK
  | `EHWPOISON
  | `EISNAM
  | `EKEYEXPIRED
  | `EKEYREJECTED
  | `EKEYREVOKED
  | `EL2HLT
  | `EL2NSYNC
  | `EL3HLT
  | `EL3RST
  | `ELIBACC
  | `ELIBBAD
  | `ELIBEXEC
  | `ELIBMAX
  | `ELIBSCN
  | `ELNRNG
  | `EMEDIUMTYPE
  | `ENOANO
  | `ENOKEY
  | `ENOMEDIUM
  | `ENONET
  | `ENOPKG
  | `ENOTBLK
  | `ENOTUNIQ
  | `EREMCHG
  | `EREMOTEIO
  | `ERESTART
  | `ERFKILL
  | `ESTRPIPE
  | `ETOOBIG
  | `EUCLEAN
  | `EUNATCH
  | `EXFULL
  | (* BSD/macOS *)
    `EAUTH
  | `EBADRPC
  | `EFTYPE
  | `ENEEDAUTH
  | `ENOCSI
  | `EPROCLIM
  | `EPROCUNAVAIL
  | `EPROGMISMATCH
  | `EPROGUNAVAIL
  | `ERPCMISMATCH
  | (* macOS-specific *)
    `EATTR
  | `EBADARCH
  | `EBADEXEC
  | `EBADMACHO
  | `EDEVERR
  | `ENOATTR
  | `ENOPOLICY
  | `EPWROFF
  | `ESHLIBVERS
  | (* Windows *)
    `EOTHER
  | (* Unknown *)
    `EUNKNOWN of int ]

(** {1 Errno Conversion} *)

(** Convert errno code to variant *)
val of_int : int -> t

(** Convert variant to errno code *)
val to_int : t -> int

(** {1 Errno Access} *)

(** Get current errno value *)
val get_errno : unit -> t

(** Get current errno as int *)
val get_errno_int : unit -> int

(** Reset errno to 0 *)
val reset_errno : unit -> unit

(** {1 Error Raising} *)

(** Generic error-raising function.

    [raise_on_error ?call f check] calls [f()] and checks the result with
    [check]. If [check] returns [true], raises a Unix_error based on the current
    errno.

    @param call Optional name of the calling function (for error messages)
    @param f Function to execute
    @param check Function to check if result indicates an error
    @return The result of [f()] if no error occurred
    @raise Unix_error if [check] returns [true] *)
val raise_on_error : ?call:string -> (unit -> 'a) -> ('a -> bool) -> 'a

(** {1 Specialized Error Checkers} *)

(** Check for negative integer return (common for syscalls). Raises Unix_error
    if result < 0. *)
val raise_on_neg : ?call:string -> (unit -> int) -> int

(** Check for null pointer return (for C functions). Raises Unix_error if result
    is null. *)
val raise_on_null : ?call:string -> (unit -> 'a Ctypes.ptr) -> 'a Ctypes.ptr

(** Check for zero return value (some functions return 0 on error). Raises
    Unix_error if result = 0. *)
val raise_on_zero : ?call:string -> (unit -> int) -> int

(** Check for None return value. Raise Unix_error if result = None. *)
val raise_on_none : ?call:string -> (unit -> 'a option) -> 'a

(** {1 Unix Error Conversion} *)

(** Convert errno variant to Unix.error *)
val to_unix_error : t -> Unix.error

(** Convert errno int to Unix.error *)
val int_to_unix_error : int -> Unix.error

(** {1 Error String Functions} *)

(** Get error message string for an errno value using strerror. This function is
    cross-platform (works on both POSIX and Windows) but not thread-safe.

    @param errnum The errno value to get the message for
    @return Error message string *)
val strerror : t -> string

(** Get error message string for an errno value using strerror_r. This function
    is thread-safe but only available on POSIX systems.

    @param buflen Optional buffer length for error message (default: 1024)
    @param errn The errno value to get the message for
    @return Error message string
    @raise Invalid_argument on Windows where strerror_r is not available
    @raise Unix_error if strerror_r fails *)
val strerror_r : ?buflen:int -> t -> string

(** {1 Native Definition Detection} *)

(** Check if an errno value is natively defined on this platform. Returns [true]
    if the errno is natively defined by the system, [false] if it's using a
    placeholder fallback value.

    This is useful to determine if an errno constant represents a real system
    error on the current platform, or if it's just a placeholder value
    (typically in the 10000+ range) that was assigned because the error doesn't
    exist on this system.

    @param errnum The errno value to check
    @return [true] if natively defined, [false] if using placeholder *)
val is_native : t -> bool
