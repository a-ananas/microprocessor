# TP1 projet Microprocesseur _(16 novembre 2022)_
Simulateur de net-list sur la base de [ce dépôt](https://github.com/hbens/sysnum-2022/tree/master/tp1) et la version finale se trouve [ici](https://github.com/a-ananas/sysnum2022_tp1).

## Quickstart
Cloner le dépôt et lancer `make` afin de lancer le simulateur sur le test `test/fulladder.net`. Dune et Ocaml sont nécessaires au bon fonctionnnement du simulateur. Pour lancer le simulateur sur d'autres fichiers, ajoutez la variable `file=<fichier>` sans préciser l'extension `.net` et ce fichier test sera simulé. Une liste des tous les fichiers disponible est disponible en lançant `make list`. La variable `n=<entier positif>` permet de contrôler le nombre de cycles sur lesquels le simulateur s'exécutera. Par exemple la commande : 
```bash
$ make file=ram n=2
```
lance le simulateur sur le programme `test/ram.net` pour 2 cycles puis s'arrête. D'autres options sont disponibles pour exécuter les tests des premières questions, vous pouvez les voir en lançant `make help` (_l'option défaut correspond à l'absence d'autres arguments que les variables_).

## Fonctionnement du simulateur
Le simulateur utilise deux espaces de mémoires : un pour les valeurs modifiées lors du cycle actuel et un autre pour les valeurs du cycle précédents. Ceci est nécessaire pour que les registres n'induisent pas de cycle et que la valeur renvoyé ne soit pas déjà modifié lors du cycle actuel. 
Ceci a pour conséquence que l'écriture en RAM prend 1 cycle de retard. La RAM s'écrit sur une table de hachage qui prend en clés les bus sous forme de tableaux de booléens. La ROM est initialisée de la mếme façon, cependant je n'ai pas trouvé de façon d'initialiser la ROM à utiliser dans le programme.

## Questionnements et difficultés
Les principales difficultés rencontrées étaient le fait d'essayer d'être le plus exhaustif possible sur les opérations réalisables. En effet, les opérations logiques que j'ai codé s'opèrent sur des valeurs de même type et de même taille. J'aurais pu faire en sorte que des opérations entre un bit et un bus soit réalisables. D'autre part, les registres utilisent un deuxième environnement de mémoire, mais j'aurais pu restructurer la programmation de l'ordre des équations afin que les opérations utilisant les registres arrivent en premier. Un autre problème est le rattrapage d'exception et notamment les entrées des programmes : la simulation s'interrompt à la moindre erreur de saisie, plutôt que de saisir l'erreur et demander une nouvelle saisie. Je devrais faire propager les exceptions au travers des différentes fonctions utilisées dans ma simulation.
