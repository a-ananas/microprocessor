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

(* finding the correct offset to jump -> replace the label with the offset *)
let find_offset_diff lst_instr lab instr_ofs = 
  let lab_ofs = List.find_map (fun a -> 
    match a with 
      | Ast.Instr(Lab_def(lab_name, lab_ofs)) when lab_name = lab -> Some(lab_ofs)
      | _ -> None)
    lst_instr in 
  match lab_ofs with Some(n) -> 4*(n - instr_ofs) | None -> failwith "erreur dans l'offset d'un jump"

let () =
  let c = open_in file in 
  let lb = Lexing.from_channel c in 
  try 
    let parsed_ast = Parser.file Lexer.token lb in 
    begin 
      close_in c;
      if !parse_only then exit 0
      else 
        begin
          let output_file = (Filename.remove_extension file)^".i" in
          let oc = open_out output_file in
          let list_instr = match parsed_ast with 
            | File(instrl) -> instrl
          in
          let ref_list = ref list_instr in
          (* WARNING : need to fill the immediates at some point with enough zeros *)
          let rec ast_to_string = function
            | [] -> close_out oc
            | Ast.Instr(R(Opc(sopc), rs1, rs2, rd, None))::ist ->
                Printf.fprintf oc "%s%s%s%s%s\n" sopc rd rs1 rs2 (String.make 12 '0') ; ast_to_string ist
            | Ast.Instr(R(Opc(sopc), rs1, rs2, rd, Some(Imm(imm))))::ist ->
                Printf.fprintf oc "%s%s%s%s%s\n" sopc rd rs1 rs2 (Lexer.int_to_binary imm 12) ; ast_to_string ist
            | Ast.Instr(R(Opc(sopc), rs1, rs2, rd, Some(Label(lab, instr_ofs))))::ist ->
                Printf.fprintf oc "%s%s%s%s%s\n" sopc rd rs1 rs2 (Lexer.int_to_binary (find_offset_diff !ref_list lab instr_ofs) 12) ; ast_to_string ist
            | Ast.Instr(I(Opc(sopc), rs, Imm(imm), rd))::ist ->
                Printf.fprintf oc "%s%s%s%s\n" sopc rd rs (Lexer.int_to_binary imm 17) ; ast_to_string ist 
            | Ast.Instr(I(Opc(sopc), rs, Label(lab, instr_ofs), rd))::ist -> 
                Printf.fprintf oc "%s%s%s%s\n" sopc rd rs (Lexer.int_to_binary (find_offset_diff !ref_list lab instr_ofs) 17) ; ast_to_string ist
            | Ast.Instr(U(Opc(sopc), Imm(imm), rd))::ist ->
                Printf.fprintf oc "%s%s%s\n" sopc rd (Lexer.int_to_binary imm 22) ; ast_to_string ist
            | Ast.Instr(U(Opc(sopc), Label(lab, instr_ofs), rd))::ist ->
                Printf.fprintf oc "%s%s%s\n" sopc rd (Lexer.int_to_binary (find_offset_diff !ref_list lab instr_ofs) 22) ; ast_to_string ist
            | Ast.Instr(Lab_def(lab, addr))::ist ->
                () ; ast_to_string ist
          in
          ast_to_string list_instr
        end 
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