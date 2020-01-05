open Ctypes

module Def (S : Cstubs.Types.TYPE) : sig
  module Utsname : sig
    type t

    val t : t structure S.typ
    val sysname : (char carray, t structure) S.field
    val nodename : (char carray, t structure) S.field
    val release : (char carray, t structure) S.field
    val version : (char carray, t structure) S.field
    val machine : (char carray, t structure) S.field
  end
end
