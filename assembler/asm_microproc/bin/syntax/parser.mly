%{
  open Ast
%}

/* EVERYTHING SHALL BE LITTLE ENDIAN */
/* every opcode with their name that are strings */
%token <string> ADDI SRLI SRAI SLLI ANDI ORI XORI ADD SUB SRL SRA SLL AND OR XOR LW SW BEQ BNE BLT BLTI BGE LUI AUIPC JAL JALR SLT SLTI
/* registers addresses that are strings */
%token <string> REG
/* immediates in binary representation */
%token <string> IMM
/* manage the end of file */
%token EOF

%start file

%type <Ast.file> file

%%

file:
  instrl = instr* EOF {File(instrl)}
;

instr:
  /* we take the first register as inputs and the last is the destination */
  | opc = opr rs1 = REG rs2 = REG rd = REG {Instr(R(opc, rs1, rs2, rd))}
  | opc = opi rs = REG imm = IMM rd = REG {Instr(I(opc, rs, imm, rd))}
  | opc = opu imm = IMM rd = REG {Instr(U(opc, imm, rd))}
;

%inline opr: 
  | s = ADD {Opc(s)}
  | s = SUB {Opc(s)}
  | s = SLL {Opc(s)}
  | s = SRL {Opc(s)}
  | s = SRA {Opc(s)}
  | s = AND {Opc(s)}
  | s = OR {Opc(s)}
  | s = XOR {Opc(s)}
  | s = SLT {Opc(s)}
  | s = SW {Opc(s)};
 
%inline opi: 
  | s = ADDI {Opc(s)}
  | s = SLLI {Opc(s)}
  | s = SRLI {Opc(s)}
  | s = SRAI {Opc(s)}
  | s = ANDI {Opc(s)}
  | s = ORI {Opc(s)}
  | s = XORI {Opc(s)}
  | s = SLTI {Opc(s)}
  | s = LW {Opc(s)}
  | s = BEQ {Opc(s)}
  | s = BNE {Opc(s)}
  | s = BLT {Opc(s)}
  | s = BLTI {Opc(s)}
  | s = BGE {Opc(s)};

%inline opu:
  | s = LUI {Opc(s)}
  | s = AUIPC {Opc(s)}
  | s = JAL {Opc(s)}
  | s = JALR {Opc(s)};
