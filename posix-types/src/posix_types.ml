open Ctypes
open Posix_base.Types
module Constants = Posix_types_constants.Def (Posix_types_generated_constants)
open Constants

let clock : (module Arithmetic) =
  mkArithmetic ~name:"clock_t" ~size:clock_t_size ~is_float:is_clock_t_float

module Clock = (val clock : Arithmetic)

type clock_t = Clock.t

let clock_t = Clock.t

let time : (module Arithmetic) =
  mkArithmetic ~name:"time_t" ~size:time_t_size ~is_float:is_time_t_float

module Time = (val time : Arithmetic)

type time_t = Time.t

let time_t = Time.t

let key : (module Arithmetic) =
  mkArithmetic ~name:"key_t" ~size:key_t_size ~is_float:is_key_t_float

module Key = (val key : Arithmetic)

type key_t = Key.t

let key_t = Key.t
let blkcnt : (module Signed) = mkSigned ~name:"blkcnt_t" ~size:blkcnt_t_size

module Blkcnt = (val blkcnt : Signed)

type blkcnt_t = Blkcnt.t

let blkcnt_t = Blkcnt.t
let blksize : (module Signed) = mkSigned ~name:"blksize_t" ~size:blksize_t_size

module Blksize = (val blksize : Signed)

type blksize_t = Blksize.t

let blksize_t = Blksize.t

let clockid : (module Unsigned) =
  mkUnsigned ~name:"clockid_t" ~size:clockid_t_size

module Clockid = (val clockid : Unsigned)

type clockid_t = Clockid.t

let clockid_t = Clockid.t
let dev : (module Unsigned) = mkUnsigned ~name:"dev_t" ~size:dev_t_size

module Dev = (val dev : Unsigned)

type dev_t = Dev.t

let dev_t = Dev.t

let fsblkcnt : (module Unsigned) =
  mkUnsigned ~name:"fsblkcnt_t" ~size:fsblkcnt_t_size

module Fsblkcnt = (val fsblkcnt : Unsigned)

type fsblkcnt_t = Fsblkcnt.t

let fsblkcnt_t = Fsblkcnt.t

let fsfilcnt : (module Unsigned) =
  mkUnsigned ~name:"fsfilcnt_t" ~size:fsfilcnt_t_size

module Fsfilcnt = (val fsfilcnt : Unsigned)

type fsfilcnt_t = Fsfilcnt.t

let fsfilcnt_t = Fsfilcnt.t
let gid : (module Unsigned) = mkUnsigned ~name:"gid_t" ~size:gid_t_size

module Gid = (val gid : Unsigned)

type gid_t = Gid.t

let gid_t = Gid.t
let id : (module Unsigned) = mkUnsigned ~name:"id_t" ~size:id_t_size

module Id = (val id : Unsigned)

type id_t = Id.t

let id_t = Id.t
let ino : (module Unsigned) = mkUnsigned ~name:"ino_t" ~size:ino_t_size

module Ino = (val ino : Unsigned)

type ino_t = Ino.t

let ino_t = Ino.t
let mode : (module Unsigned) = mkUnsigned ~name:"mode_t" ~size:mode_t_size

module Mode = (val mode : Unsigned)

type mode_t = Mode.t

let mode_t = Mode.t
let nlink : (module Unsigned) = mkUnsigned ~name:"nlink_t" ~size:nlink_t_size

module Nlink = (val nlink : Unsigned)

type nlink_t = Nlink.t

let nlink_t = Nlink.t
let off : (module Signed) = mkSigned ~name:"off_t" ~size:off_t_size

module Off = (val off : Signed)

type off_t = Off.t

let off_t = Off.t
let pid : (module Signed) = mkSigned ~name:"pid_t" ~size:pid_t_size

module Pid = (val pid : Signed)

type pid_t = Pid.t

let pid_t = Pid.t
let size : (module Unsigned) = mkUnsigned ~name:"size_t" ~size:size_t_size

module Size = (val size : Unsigned)

type size_t = Size.t

let size_t = Size.t
let ssize : (module Signed) = mkSigned ~name:"ssize_t" ~size:ssize_t_size

module Ssize = (val ssize : Signed)

type ssize_t = Ssize.t

let ssize_t = Ssize.t

let suseconds : (module Signed) =
  mkSigned ~name:"suseconds_t" ~size:suseconds_t_size

module Suseconds = (val suseconds : Signed)

type suseconds_t = Suseconds.t

let suseconds_t = Suseconds.t
let uid : (module Unsigned) = mkUnsigned ~name:"uid_t" ~size:uid_t_size

module Uid = (val uid : Unsigned)

type uid_t = Uid.t

let uid_t = Uid.t

let useconds : (module Unsigned) =
  mkUnsigned ~name:"useconds_t" ~size:useconds_t_size

module Useconds = (val useconds : Unsigned)

type useconds_t = Useconds.t

let useconds_t = Useconds.t
