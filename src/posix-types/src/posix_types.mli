open Ctypes
open Posix_base.Types

(** POSIX types from <sys/types.h>. This module is used to build further POSIX
    bindings. See {!Posix_time2_types} for an example. *)

(** {2 POSIX arithmetic types} *)

(** {3 Base modules} *)

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

(** {3 Types} *)

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

(** {3 Values} *)

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

(** {2 Pthread API} *)

(** {3 Base module} *)

module Pthread : sig
  module Attr : sig
    type t

    val t : t Ctypes.typ
  end

  module Cond : sig
    type t

    val t : t Ctypes.typ
  end

  module Condattr : sig
    type t

    val t : t Ctypes.typ
  end

  module Key : sig
    type t

    val t : t Ctypes.typ
  end

  module Mutex : sig
    type t

    val t : t Ctypes.typ
  end

  module Mutexattr : sig
    type t

    val t : t Ctypes.typ
  end

  module Once : sig
    type t

    val t : t Ctypes.typ
  end

  module Rwlock : sig
    type t

    val t : t Ctypes.typ
  end

  module Rwlockattr : sig
    type t

    val t : t Ctypes.typ
  end

  module T : sig
    type t

    val t : t Ctypes.typ
  end

  type attr_t = Attr.t
  type cond_t = Cond.t
  type condattr_t = Condattr.t
  type key_t = Key.t
  type mutex_t = Mutex.t
  type mutexattr_t = Mutexattr.t
  type once_t = Once.t
  type rwlock_t = Rwlock.t
  type rwlockattr_t = Rwlockattr.t
  type t = T.t
end

(** {3 Types} *)

type pthread_attr_t = Pthread.Attr.t
type pthread_cond_t = Pthread.Cond.t
type pthread_condattr_t = Pthread.Condattr.t
type pthread_key_t = Pthread.Key.t
type pthread_mutex_t = Pthread.Mutex.t
type pthread_mutexattr_t = Pthread.Mutexattr.t
type pthread_once_t = Pthread.Once.t
type pthread_rwlock_t = Pthread.Rwlock.t
type pthread_rwlockattr_t = Pthread.Rwlockattr.t
type pthread_t = Pthread.T.t

(** {3 Values} *)

val pthread_attr_t : pthread_attr_t Ctypes.typ
val pthread_cond_t : pthread_cond_t Ctypes.typ
val pthread_condattr_t : pthread_condattr_t Ctypes.typ
val pthread_key_t : pthread_key_t Ctypes.typ
val pthread_mutex_t : pthread_mutex_t Ctypes.typ
val pthread_mutexattr_t : pthread_mutexattr_t Ctypes.typ
val pthread_once_t : pthread_once_t Ctypes.typ
val pthread_rwlock_t : pthread_rwlock_t Ctypes.typ
val pthread_rwlockattr_t : pthread_rwlockattr_t Ctypes.typ
val pthread_t : pthread_t Ctypes.typ
