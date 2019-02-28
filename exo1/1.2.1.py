# -*-coding:Latin-1 -*
import os
import math

n = -1
while n<1:
    n = input("Entrez votre factorielle ici(un r�el positif): ")
    try:
        n = int(n)
    except ValueError:
        print("Vous n'avez pas saisi de nombre")
        n = -1
    continue

i = 1
resultat = 1
while i <= n :
    resultat = resultat * i
    i = i+1

print("La factorielle de", n, "est", resultat)

#os.system("pause")

