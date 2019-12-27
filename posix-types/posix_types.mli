open Ctypes
open Posix_base.Types

(** Some POSIX types. *)

(* arithmetic types from <sys/types.h> *)
(** {2 POSIX arithmetic types} *)

module Blkcnt : Signed.S
module Blksize : Signed.S
module Clock : Arithmetic
module Clockid : Unsigned.S
module Dev : Unsigned.S
module Fsblkcnt : Unsigned.S
module Fsfilcnt : Unsigned.S
module Gid : Unsigned.S
module Id : Unsigned.S
module Ino : Unsigned.S
module Key : Arithmetic
module Mode : Unsigned.S
module Nlink : Unsigned.S
module Off : Signed.S
module Pid : Signed.S
module Size : Unsigned.S
module Ssize : Signed.S
module Time : Arithmetic
module Uid : Unsigned.S
module Useconds : Unsigned.S
module Suseconds : Signed.S

type blkcnt_t = Blkcnt.t
type blksize_t = Blksize.t
type clock_t = Clock.t
type clockid_t = Clockid.t
type dev_t = Dev.t
type fsblkcnt_t = Fsblkcnt.t
type fsfilcnt_t = Fsfilcnt.t
type gid_t = Gid.t
type id_t = Id.t
type ino_t = Ino.t
type key_t = Key.t
type mode_t = Mode.t
type nlink_t = Nlink.t
type off_t = Off.t
type pid_t = Pid.t
type size_t = Size.t
type ssize_t = Ssize.t
type time_t = Time.t
type uid_t = Uid.t
type useconds_t = Useconds.t
type suseconds_t = Suseconds.t

(** {3 Values representing POSIX arithmetic types} *)

val blkcnt_t : blkcnt_t typ
val blksize_t : blksize_t typ
val clock_t : clock_t typ
val clockid_t : clockid_t typ
val dev_t : dev_t typ
val fsblkcnt_t : fsblkcnt_t typ
val fsfilcnt_t : fsfilcnt_t typ
val gid_t : gid_t typ
val id_t : id_t typ
val ino_t : ino_t typ
val key_t : key_t typ
val mode_t : mode_t typ
val nlink_t : nlink_t typ
val off_t : off_t typ
val pid_t : pid_t typ
val size_t : size_t typ
val ssize_t : ssize_t typ
val time_t : time_t typ
val uid_t : uid_t typ
val useconds_t : useconds_t typ
val suseconds_t : suseconds_t typ

(* non-arithmetic types from <sys/types.h> *)
(** {2 POSIX non-arithmetic types} *)

(*
type sigset_t

(** {3 Values representing POSIX non-arithmetic types} *)

val sigset_t             : sigset_t typ
*)
