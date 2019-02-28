from random import randint
import time

alphabet="01"
chaine = "000000"


n = 8

def chainAlea(n):
    rC = ""
    j = 0
    while j < n:
        i = randint(0,1)
        rC += alphabet[i]
        rC = rC.upper()
        j +=1
    return rC

def rechercheDebut(chaine,n):
    t = chainAlea(n)
    i = 0
    while chaine != t[:len(chaine)]:
        t = chainAlea(n)
        i +=1
    return t, i

start_time = time.time()
print(rechercheDebut(chaine,n))
print("Exec pour les",len(chaine),"1eres lettres sur une chaine de",n,": %s sec ---" % (time.time() - start_time))
