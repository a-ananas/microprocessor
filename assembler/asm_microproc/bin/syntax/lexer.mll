
{
  open Lexing
  open Parser

  (* Table to get all the instructions *)
  (* /!\ BEWARE TO LITTLE ENDIAN *)
  let instr_tbl = 
    [
      "addi",  "00000";
      "srli",  "01000";
      "srai",  "11000";
      "slli",  "00100";
      "andi",  "10100";
      "ori",   "01100";
      "xori",  "11100";
      "add",   "00010";
      "sub",   "10010";
      "srl",   "01010";
      "sra",   "11010";
      "sll",   "00110";
      "and",   "10110";
      "or",    "01110";
      "xor",   "11110";
      (*"slt",   00001; problem with the slt and slti opcodes*)
      "beq",   "11001";
      "bne",   "00101";
      "blt",   "10101";
      "blti",  "01101";
      "bge",   "11101";
      "lui",   "00011";
      "auipc", "10011";
      "jal",   "11011";
      "jalr",  "00111";
      (*"lw",    01111; "sw",    11111; problems between lw and slt*)
    ]

    (* convert a integer to a binary string in little endian *)
    let int_to_binary i = 
      let inp = ref i in
      let s = ref "" in
      let p = ref 1 in 
      for i = 1 to 5 do
        p := !p * 2;
        if !inp mod !p = 0 then s := (!s)^"0" else s := (!s)^"1";
        inp := !inp - (!inp mod !p)
  done;
  !s;;

  let manage_instr =
    let h = Hashtbl.create 32 in
    List.iter (fun (key, token) -> Hashtbl.add h key token) instr_tbl;
    (* create the registers 0 -> 16 with a binary address in a string*)
    let regs = List.init 16 (fun i -> "x"^(string_of_int i), (int_to_binary i)) in 
    List.iter (fun (key, token) -> Hashtbl.add h key token) regs;
}

(* white spaces *)
let space = [' ' '\t' '\r']

(* digits *)
let digits = ['0'-'9']

(* integers *)
let integers = '0' | (['1'-'9']digit*)

(* registers syntax -> xN with N from 0 to 16*)
let registers = 'x'digit | "x1"['0'-'6']
