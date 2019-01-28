# -*-coding:Latin-1 -*
import os
import math

rayon = -1
while rayon<0:
    rayon = input("Entrez votre rayon ici(un réel positif): ")
    try:
        rayon = int(rayon)
    except ValueError:
        print("Vous n'avez pas saisi de nombre")
        rayon = -1
    continue

class cercle:
    def __init__(self,r):
        self.r = r
    def perimetre(r):
        return round(2 * r * math.pi,2)
    def aire(r):
        return round(math.pi * (r**2),2)

print("Le périmètre est de", cercle.perimetre(rayon), "et l'aire est de", cercle.aire(rayon))

#os.system("pause")
