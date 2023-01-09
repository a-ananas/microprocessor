open Lexing
open Syntax 

let thomas = ref false
let parse_only = ref false

let spec = 
  [
    "--thomas-the-train", Arg.Set thomas, "he goes tchoutchou";
    "--parser-only", Arg.Set parse_only, "stop after parsing"
  ]

let usage = "asm [options] file.x"

let file =
  let file = ref None in 
  let set_file s = 
    if not (Filename.check_suffix s ".x") then 
      raise (Arg.Bad "no .x extension");
    file := Some s
  in
  Arg.parse spec set_file usage;
  match !file with Some f -> f | None -> Arg.usage spec usage; exit 1

let report (b, e) = 
  let l = b.pos_lnum in
  let fc = b.pos_cnum - b.pos_bol + 1 in 
  let lc = e.pos_cnum - b.pos_bol + 1 in 
  Format.eprintf "Fichier \"%s\" ligne %d characteres %d-%d :\n" file l fc lc 

let () =
  let c = open_in file in 
  let lb = Lexing.from_channel c in 
  try 
    let _parsed_ast = Parser.file Lexer.token lb in 
    begin 
      close_in c;
      if !parse_only then exit 0
    end
  with 
  | Lexer.Lexing_error(s) -> 
      report (Lexing.lexeme_start_p lb, Lexing.lexeme_end_p lb);
      Format.eprintf "\tErreur lexicale : %s\n" s;
      exit 1
  | Parser.Error ->
      report (Lexing.lexeme_start_p lb, Lexing.lexeme_end_p lb);
      Format.eprintf "\tErreur syntaxique\n";
      exit 1
  | e ->
      Format.eprintf "\tAnomalie : %s\n" (Printexc.to_string e);
      exit 2

