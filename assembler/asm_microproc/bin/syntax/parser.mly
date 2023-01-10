%{
  open Ast

  let addr_counter = ref 0

%}

/* EVERYTHING SHALL BE LITTLE ENDIAN */
/* every opcode with their name that are strings */
%token <string> ADDI SRLI SRAI SLLI ANDI ORI XORI ADD SUB SRL SRA SLL AND OR XOR LW SW BEQ BNE BLT BLTI BGE LUI AUIPC JAL JALR SLT SLTI
/* registers addresses that are strings */
%token <string> REG
/* immediates in binary representation */
%token <int> IMM
/* labels names */
%token <string> LABEL
/*  colon for end of label definition */
%token END_LABEL
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
  | opc = opr rd = REG rs1 = REG rs2 = REG {addr_counter := !addr_counter + 1 ; Instr(R(opc, rs1, rs2, rd))}
  | opc = opi rd = REG rs = REG imm = IMM {addr_counter := !addr_counter + 1 ; Instr(I(opc, rs, Imm(imm), rd))}
  | opc = opi rd = REG rs = REG lab = LABEL {addr_counter := !addr_counter + 1 ; Instr(I(opc, rs, Label(lab, !addr_counter), rd))}
  | opc = opu rd = REG imm = IMM {addr_counter := !addr_counter + 1 ; Instr(U(opc, Imm(imm), rd))}
  | opc = opu rd = REG lab = LABEL {addr_counter := !addr_counter + 1 ; Instr(U(opc, Label(lab, !addr_counter), rd))}
  | lab = LABEL END_LABEL {Instr(Lab_def(lab, !addr_counter+1))}
;

%inline opr: 
  | s = ADD  {Opc(s)}
  | s = SUB  {Opc(s)}
  | s = SLL  {Opc(s)}
  | s = SRL  {Opc(s)}
  | s = SRA  {Opc(s)}
  | s = AND  {Opc(s)}
  | s = OR   {Opc(s)}
  | s = XOR  {Opc(s)}
  | s = SLT  {Opc(s)}
  | s = SW   {Opc(s)}
  | s = BEQ  {Opc(s)}
  | s = BNE  {Opc(s)}
  | s = BLT  {Opc(s)}
  | s = BLTI {Opc(s)}
  | s = BGE  {Opc(s)};
 
%inline opi: 
  | s = ADDI {Opc(s)}
  | s = SLLI {Opc(s)}
  | s = SRLI {Opc(s)}
  | s = SRAI {Opc(s)}
  | s = ANDI {Opc(s)}
  | s = ORI  {Opc(s)}
  | s = XORI {Opc(s)}
  | s = SLTI {Opc(s)}
  | s = LW   {Opc(s)};

%inline opu:
  | s = LUI   {Opc(s)}
  | s = AUIPC {Opc(s)}
  | s = JAL   {Opc(s)}
  | s = JALR  {Opc(s)};
