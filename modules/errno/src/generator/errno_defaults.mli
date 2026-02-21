type errno_def = {
  name : string;
  default : int;
  overrides : (string list * int) list;
}

val errno_defs : errno_def list
val errno_aliases : (string * string) list
val errno_defaults : (string * int) list
