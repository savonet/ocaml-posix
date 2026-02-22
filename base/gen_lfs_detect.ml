let read_size filename =
  let ic = open_in filename in
  let size = int_of_string (String.trim (input_line ic)) in
  close_in ic;
  size

let () =
  let size_native = read_size Sys.argv.(1) in
  let size_lfs = read_size Sys.argv.(2) in
  let needs_lfs = size_lfs > size_native in
  let c_flags = if needs_lfs then "-D_FILE_OFFSET_BITS=64" else "" in
  Printf.printf "let needs_lfs = %b\n" needs_lfs;
  Printf.printf "let c_flags = \"%s\"\n" c_flags
