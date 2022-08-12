let () = 
  print_endline "Chest 0.0.06.(1)";;
  print_endline "chest [Project directory]";;
  let directory = (Array.get Sys.argv 1);;
  let gem_source_file = (String.concat directory [""; "/main.gem"]);;

  Sys.command (String.concat "mkdir " [""; directory]);;
  Sys.command (String.concat "touch " [""; gem_source_file]);;
  Sys.command (String.concat "echo \"Remember 'Hello,World!' as msg\nWrite msg\" > " [""; gem_source_file]);;