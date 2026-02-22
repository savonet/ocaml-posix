open Ctypes

module Def (S : Cstubs.Types.TYPE) : sig
  module Option : sig
    type t

    val t : t structure S.typ
    val name : (string, t structure) S.field
    val has_arg : (int, t structure) S.field
    val flag : (int ptr, t structure) S.field
    val _val : (int, t structure) S.field
  end
end
