open Posix_uname

let () =
  let { sysname; nodename; release; version; machine } = uname () in
  Printf.printf
    "sysname: %s\nnodename: %s\nrelease: %s\nversion: %s\nmachine: %s\n%!"
    sysname nodename release version machine
