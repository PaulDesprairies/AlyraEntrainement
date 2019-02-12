from random import randint
import time

alphabet="0123456789abcdef"
chaine = "00"
#coeff ="3218a5"
#exp = "17"
coeff ="FFFFFFFFF"
exp = "22"

def from_bit_to_cible(coeff, exp):
    coeff = int(coeff,16)
    exp = int(exp,16)
    cible = coeff * 2 **(8*(exp-3))
    cible = hex(cible)[2:]
    zeroing = 0
    zeroCible = 64-len(cible)
    while zeroing < zeroCible:
        cible = "0" + cible
        zeroing = zeroing + 1
    return cible


def chainAlea():
    rC = ""
    j = 0
    n= len(alphabet)
    while j < 64:
        i = randint(0,n-1)
        rC += alphabet[i]
        j +=1
    return rC

def check_inferieur(coeff, exp, condensat):
    cible = from_bit_to_cible(coeff, exp)
    if condensat < cible:
        print(True)
    else:
        print(False, "\n cible:", cible, "\n vs \n condensat:", condensat)

def cibleAtteinte(chaine,n):
    t = chainAlea(n)
    i = 0
    while chaine != t[:len(chaine)]:
        t = chainAlea(n)
        i +=1
    return t, i

condensat = chainAlea()
check_inferieur(coeff, exp, condensat)

