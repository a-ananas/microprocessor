# ALU explication

## shift: Oscar

Trois fonctions de shift, shift left logical : multiplication par 2,
puis shift right logical (seulement des 0 de remplacement), division par 2
shift right arithmetical, division par 2 en conservant le signe


les methodes sont sll, srl, sra, et elles existent toutes en version *k, qui presise directement le k de decalage.
Telles quelles, les methodes prennent b, un bus de taille 5, qui code le decalage sur 5 bits.