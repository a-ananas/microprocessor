
{
  open Lexing
  open Parser

  exception Lexing_error of string

  (* Table to get all the instructions *)
  (* /!\ BEWARE TO LITTLE ENDIAN *)
  let instr_tbl = 
    [
      "addi",  ADDI "00000";
      "srli",  SRLI "01000";
      "srai",  SRAI "11000";
      "slli",  SLLI "00100";
      "andi",  ANDI "10100";
      "ori",   ORI "01100";
      "xori",  XORI "11100";
      "add",   ADD "00010";
      "sub",   SUB "10010";
      "srl",   SRL "01010";
      "sra",   SRA "11010";
      "sll",   SLL "00110";
      "and",   AND "10110";
      "or",    OR "01110";
      "xor",   XOR "11110";
      "lw",    LW "00001";
      "sw",    SW "10001";
      "beq",   BEQ "11001";
      "bne",   BNE "00101";
      "blt",   BLT "10101";
      "blti",  BLTI "01101";
      "bge",   BGE "11101";
      "lui",   LUI "00011";
      "auipc", AUIPC "10011";
      "jal",   JAL "01011";
      "jalr",  JALR "11011";
      "slt",   SLT "01111";
      "slti",  SLTI "11111";
    ]

  (* useful function to make powers of 2 *)
  let rec pow2 = function
    | 0 -> 1
    | n -> 2*(pow2 (n-1))

    (* convert a integer to a binary string in little endian *)
    let int_to_binary i n = 
      let pow = pow2 n in
      let inp = if i >= 0 then ref i else ref (pow+i mod pow) in
      let s = ref "" in
      let p = ref 1 in 
      for _ = 1 to n do
        p := !p * 2;
        if !inp mod !p = 0 then s := (!s)^"0" else s := (!s)^"1";
        inp := !inp - (!inp mod !p)
      done;
  !s;;

  let manage_instr =
    let h = Hashtbl.create 32 in
    List.iter (fun (key, token) -> Hashtbl.add h key token) instr_tbl;
    (* create the registers 0 -> 16 with a binary address in a string*)
    let regs = List.init 16 (fun i -> ("x"^(string_of_int i), (REG(int_to_binary i 5)))) in 
    List.iter (fun (key, token) -> Hashtbl.add h key token) regs;
    fun key -> 
      try Hashtbl.find h key with _ -> raise(Lexing_error "Ca marche pas le mot là")
}

(* white spaces *)
let space = [' ' '\t' '\r']

(* digits *)
let digit = ['0'-'9']

(* integers *)
let integer = '0' | ('-'?['1'-'9']digit*)

(* characters *)
let character = ['a'-'z']

(* registers syntax -> xN with N from 0 to 16*)
let register = 'x'digit | 'x''1'['0'-'6']

(* lexing the tokens *)
rule token = parse 
  | '\n'                {new_line lexbuf; token lexbuf}
  | '#' [^ '\n']*       {token lexbuf}
  | '#' [^ '\n']* eof   {EOF}
  | space+              {token lexbuf}
  | integer as i        {IMM (int_to_binary (int_of_string i) 16)}
  | character+ as instr {manage_instr instr}
  | register as rg      {manage_instr rg}
  | eof                 {EOF}
  | _ as c              {raise(Lexing_error ("illegal char : "^(String.make 1 c)))}
