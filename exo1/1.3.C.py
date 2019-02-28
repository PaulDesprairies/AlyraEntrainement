#Fonction de traitement d'entrées (pas d'espaces)
def space_killer(texte):
    t=""
    for x in texte:
        if x.isspace() :
          x=""
        t += x
    return t.upper()

def clef_check():
    nombre = -1
    while nombre < 0 :
        try:
            nombre = int(input("Tapez votre clé de cryptographie (entier positif ou nul) : "))
        except ValueError:
            print("Vous n'avez pas saisi de nombre")
    return nombre

def formation_element(texte,clef):
    res=[]
    i = 0
    l = int((len(texte)/clef))
    while i < clef :
        n = 0
        lettre = ""
        while n < l  :
            lettre += texte[(n*clef)+i]
            n+=1

        if len(texte) > (n*clef)+i :
            lettre += texte[(n*clef)+i]
        res.append(lettre)
        i+=1

    print(res)

    
#Saisie et pré-traitement de la clé de codage
texte = input("Que voulez-vous chiffrer ? :")
texte = space_killer(texte)
clef = clef_check()


#Appel de fonction
formation_element(texte,clef)
