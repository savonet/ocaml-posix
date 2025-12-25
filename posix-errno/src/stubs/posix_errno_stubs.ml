open Ctypes

module Def (F : Cstubs.FOREIGN) = struct
  open F

  (* Errno access functions *)
  let posix_errno_get_errno =
    foreign "posix_errno_get_errno" (void @-> returning int)

  let posix_errno_set_errno =
    foreign "posix_errno_set_errno" (int @-> returning void)

  (* strerror function - returns OCaml string (cross-platform, not thread-safe) *)
  let strerror = foreign "strerror" (int @-> returning string)

  (* strerror_r function - POSIX version returns int (0 on success) *)
  (* Raises Invalid_argument on Windows *)
  let strerror_r =
    foreign "posix_errno_strerror_r" (int @-> ptr char @-> int @-> returning int)

  (* strlen function to get string length *)
  let strlen = foreign "strlen" (ptr char @-> returning int)
end
