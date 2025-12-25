module System_detect : sig
  val system : string
  val os_type : string
end

val errno_defaults : (string * int) list
val errno_aliases : (string * string) list
