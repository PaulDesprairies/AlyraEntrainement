import os
import math
import sys
from itertools import *




transactions = [[600,1500], [700, 1500], [800, 2000], [1000, 2800], [1200, 3500], [1300, 5000], [2000, 13000], [6000, 9000]]
   

#on trie la liste par le tips pour chaque transaction unique
transactions_trie = sorted(transactions, key=lambda l:l[1], reverse=True)


#on cree on fonction pour creer des combinaisons en commençant par les plus hautes cad celles qui sont le plus susceptibles de nous rapporter le plus gros tips
def combine_transactions(n):
    combinaisons = combinations_with_replacement(transactions_trie, n)
    return combinaisons

maxOctet = 6000
n = 1
tips_final = 0
n_final = 0
#soit n le nb de transactions essayees
#on sait qu'il ne peut y avoir plus de 10 transactions car il est impossible que la somme de 10 transactions soit inferieur à 6000 octet
while n <=10 :
    A = combine_transactions(n)
    for x in A:
        i=0
        pourboire = 0
        octet = 0
        while i < n :
            pourboire = pourboire + x[i][1]
            octet = octet + x[i][0]
            i+=1
        #dès que la somme des transactions atteint 6000, on arrête : c'est le maximum en tips possible (car la liste est triee)
        if octet <= maxOctet :
            #print("Pour", n,"transactions, le pourboire max est de", pourboire, "pour", octet, "octet.")
            break
    if pourboire > tips_final :
        tips_final = pourboire
        n_final = n
    n+=1
    
print("Le pourboire max possible est de", tips_final, "pour", n_final, "transaction.")



