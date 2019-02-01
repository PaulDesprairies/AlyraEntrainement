# -*-coding:Latin-1 -*
import os
import math
import sys


NoneType = type(None)

class Noeud:
    def __init__(self, v):
        self.gauche = None
        self.droit = None
        self.valeur = v


class Arbre:
    def __init__(self):
        self.racine = None
        
    def ajouter(self, val):
        if(self.racine == None):
            self.racine = Noeud(val)
        else:
            self._ajouter(val, self.racine)

    def _ajouter(self, val, nd):
        if(val < nd.valeur):
            if(nd.gauche is not None):
                self._ajouter(val, nd.gauche)
            else:
                nd.gauche = Noeud(val)
        else:
            if(nd.droit is not None):
                self._ajouter(val, nd.droit)
            else:
                nd.droit = Noeud(val)
                
    def avoirRacine(self):
        return self.racine

    #Recherche un nombre dans l'arbre
    def _recherche(self, nombre, noeud) :
        if isinstance(noeud, NoneType):
            print(nombre, "n'existe pas dans l'arbre.")
        else :
            if(nombre < noeud.valeur):
                #print("gauche")
                self._recherche(nombre, noeud.gauche)
            elif(nombre > noeud.valeur):
                #print("droite")
                self._recherche(nombre, noeud.droit)
            elif(nombre == noeud.valeur):
                print(nombre, "a été trouvé !")
                #préparation de la méthode de suppression
                #print (noeud.gauche, noeud.valeur, noeud.droit)
                return noeud
            
    #Affiche l'arbre sur une exploration infixe (croissant)    
    def _exploration_infixe(self, noeud):
        res=[]
        if noeud:
            #print("gauche")
            res = self._exploration_infixe(noeud.gauche)
            #print(noeud.valeur)
            #print("droite")
            res.append(noeud.valeur)
            res = res + self._exploration_infixe(noeud.droit)
        return res

    #Sélectionne le noeud qui convient pour la suppression d'un node à deux fils non vide et renvoit sa valeur
    def _halo(self, cible):
        faux_noeud = Noeud(cible)
        res = arbre._exploration_infixe(arbre.avoirRacine())
        resultat = 0
        if cible in res :
            faux_noeud.droit = res[res.index(cible) + 1]  #il y aura toujours un +1 ou un -1 puisqu'on est dans le cas de la suppression avec deux fils
            faux_noeud.gauche = res[res.index(cible) - 1] #
        else:
            print("L'élément séléectionné n'est pas dans l'arbre")
        #print (faux_noeud.gauche, faux_noeud.valeur, faux_noeud.droit)
        if faux_noeud.droit - faux_noeud.valeur > faux_noeud.valeur - faux_noeud.gauche :
            resultat = faux_noeud.gauche
        else :
            resultat = faux_noeud.droit
        print(resultat)

    #Affiche l'arbre sur une exploration prefixe (décroissant)    
    def _exploration_prefixe(self, noeud):
        if noeud:
            #print("droit")
            self._exploration_prefixe(noeud.droit)
            print(noeud.valeur)
            #print("gauche")
            self._exploration_prefixe(noeud.gauche)

    #Methode non fonctionnelle yet
    def _supprimer(self,valeur) :
        #cible = arbre._recherche(valeur, arbre.avoirRacine())
        cible = arbre._recherche(valeur, arbre.avoirRacine())
        print(type(cible))
        if cible.gauche is None and cible.droit is None :
            arbre._recherche(valeur, arbre.avoirRacine()).valeur = None
            print("Noeud",valeur," effacé")
        elif cible.gauche is not None and cible.droit is None :
            arbre._recherche(valeur, arbre.avoirRacine()).valeur = cible.droit
            print("Valeur du noeud remplacée par son fils gauche :",cible.droit)
        elif cible.gauche is None and cible.droit is not None :
            arbre._recherche(valeur, arbre.avoirRacine()).valeur = cible.gauche
            print("Valeur du noeud remplacée par son fils droit :",cible.droit)
        elif cible.gauche is not None and cible.droit is not None :
            arbre._recherche(valeur, arbre.avoirRacine()).valeur = arbre._halo(valeur)
            print("Valeur du noeud remplacée par la plus proche valeur de l'arbre :",arbre._halo(valeur))

                  


arbre = Arbre()
arbre.ajouter(15)
arbre.ajouter(11)
arbre.ajouter(20)
arbre.ajouter(9)
arbre.ajouter(40)
arbre.ajouter(16)
arbre.ajouter(25)
arbre.ajouter(19)


