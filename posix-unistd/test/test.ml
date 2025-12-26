open OUnit2

let suite =
  "posix-unistd tests"
  >::: [
         Test_constants.suite;
         Test_file_descriptors.suite;
         Test_files.suite;
         Test_directories.suite;
         Test_io.suite;
         Test_sync.suite;
         Test_process.suite;
         Test_terminal.suite;
         Test_sysinfo.suite;
         (* Error handling tests *)
         Test_io_errors.suite;
         Test_file_descriptors_errors.suite;
         Test_files_errors.suite;
         Test_directories_errors.suite;
         Test_process_errors.suite;
         Test_terminal_errors.suite;
         Test_sysinfo_errors.suite;
       ]

let () =
  at_exit Test_helpers.flush_verbose;
  run_test_tt_main suite
