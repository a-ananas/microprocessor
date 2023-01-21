## registres necessaires
# input dans x31
# output dans x15

xor  x31 x31 x31
xor  x15 x15 x15
addi x31 x31 2035 

## registres supp
# x30 : sauvegarde de x31 et de x15 pdt les tests
# x20 : tests de valeurs 
# x19 : 0
xor  x20 x20 x20
xor  x19 x19 x19


# init x31 (ajouter 1 à la fin pour les tests)
slli x31 x31 1
addi x31 x31 1
jal  x31 BOUCLE

BOUCLE:
andi x30 x31 16384
srli x30 x30 14
slli x15 x15 1
add  x15 x15 x30
slli x31 x31 1

andi x20 x31 16383
beq  x20 x20 x19 END

jal x15 TEST_UNT

TEST_UNT:
xor  x20 x20 x20
addi x20 x20 4             # 4
andi x30 x15 15            # x
bge  x15 x20 x30 TEST_TEN  # si 4 >= x
addi x15 x15 3             # +3 aux unités
jal  x15 TEST_TEN

TEST_TEN:
addi x20 x20 60            # 64
andi x30 x15 240           # x
bge  x15 x20 x30 TEST_HUN  # si 4 >= x
addi x15 x15 48            # +3 aux dizaines
jal  x15 TEST_HUN

TEST_HUN:
addi x20 x20 960           # 1024
andi x30 x15 3840          # x
bge  x15 x20 x30 TEST_THO  # si 4 >= x
addi x15 x15 768           # +3 aux centaines
jal  x15 TEST_THO

TEST_THO:
addi x20 x20 15360         # 16384
andi x30 x15 61440         # x
bge  x15 x20 x30 BOUCLE    # si 4 >= x
addi x15 x15 12304         # +3 aux milliers
jal  x15 BOUCLE

END:
# pour la visualisation de l'output je mets les dizaines les centaines et le milliers à part
addi x30 x15 0
andi x0 x30 15
srli x30 x30 4
andi x1 x30 15
srli x30 x30 4
andi x2 x30 15
srli x30 x30 4
andi x3 x30 15
srli x30 x30 4
jal  x15 END