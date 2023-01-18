# input dans x31: on fait le cas où on aura que 2 digits 
# il faut donc tester si x31 n'est pas trop grand (à savoir plus grand que 100)

xor x31 x31 x31
addi x31 x31 16 

# reg à utiliser (init et valeurs de départs -> REUTILISER)
# x30 -> inf à 100
# x29 -> inf à 5
# x28 -> sup à 0
# x20 -> les unités
# x21 -> les dizaines
xor x30 x30 x30
xor x29 x29 x29
xor x28 x28 x28
addi x30 x30 100
addi x29 x29 4
xor x20 x20 x20
xor x21 x21 x21

# check si inf à 100 faire un else -> LOOP_SUX un peu violent lol
blt x31 x31 x30 INF_100
jal x31 LOOP_SUX

INF_100:
# x20 -> unités : déplace le plus grand bit (le 7ème) dans x20

# on regarde le plus grand bit possible et on le met dans le LSB de x5
andi x5 x31 64
srli x5 x5 6

# on fait de la place pour ce nouveau bit et on l'ajoute à x20
slli x20 x20 1
add x20 x20 x5

# on décale le bit à considérer dans x31 et on met à 0 tout ce qui dépasse des bits qu'on considère
slli x31 x31 1
andi x31 x31 127

# condition de boucle : si on a une valeur plus grande que 4 on doit ajouter 3 et passer aux centaines
blt x20 x29 x20 PLUS_3
blt x31 x28 x31 INF_100
jal x31 SUCCESS

PLUS_3:
addi x20 x20 3
jal x31 INF_100

SUCCESS:
add x21 x21 x20
srli x21 x21 4
jal x20 LOOP_SUX

LOOP_SUX:
addi x21 x21 0
jal x21 LOOP_SUX

