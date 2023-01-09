
{
  open Lexing
  open Parser

  (* Table to get all the instructions *)
  (* /!\ BEWARE TO LITTLE ENDIAN *)
  let instr_tbl = 
    [
      "addi",  00000;
      "srli",  01000;
      "srai",  11000;
      "slli",  00100;
      "andi",  10100;
      "ori",   01100;
      "xori",  11100;
      "add",   00010;
      "sub",   10010;
      "srl",   01010;
      "sra",   11010;
      "sll",   00110;
      "and",   10110;
      "or",    01110;
      "xor",   11110;
      (*"slt",   00001; problem with the slt and slti opcodes*)
      "beq",   11001;
      "bne",   00101;
      "blt",   10101;
      "blti",  01101;
      "bge",   11101;
      "lui",   00011;
      "auipc", 10011;
      "jal",   11011;
      "jalr",  00111;
      (*"lw",    01111; "sw",    11111; problems between lw and slt*)
    ]

  let manage_instr =
    let h = Hashtbl.create 32 in
    List.iter (fun (key, token) -> Hashtbl.add h key token) instr_tbl;
}

(* white spaces *)
let space = [' ' '\t' '\r']

(* digits *)
let digits = ['0'-'9']

(* integers *)
let integers = '0' | (['1'-'9']digit*)
