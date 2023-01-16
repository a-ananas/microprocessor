# le double dabble : commençons simple -> on prend 11 et on le transforme en un truc mieux 

# init à 0 tous les registres dont on aura besoin
xor x0 x0 x0
xor x1 x1 x1
xor x2 x2 x2
xor x3 x3 x3
xor x4 x4 x4
addi x0 x0 11 # on met l'input sur x0

# valeurs pour avoir juste les slice qui nous interessent
addi x1 x1 15
addi x2 x2 240

# Démarre l'algo : 
sll

#marche pas :(
blti x0 x0 x0

ADD3:
addi x0 x0 3
