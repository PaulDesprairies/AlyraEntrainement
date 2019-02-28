Alphabet = [["a",1],
            ["b",2],
            ["c",3],
            ["d",4],
            ["e",5],
            ["f",6],
            ["g",7],
            ["h",8],
            ["i",9],
            ["j",10],
            ["k",11],
            ["l",12],
            ["m",13],
            ["n",14],
            ["o",15],
            ["p",16],
            ["q",17],
            ["r",18],
            ["s",19],
            ["t",20],
            ["u",21],
            ["v",22],
            ["w",23],
            ["x",24],
            ["y",25],
            ["z",26]]

Alphabet = dict(Alphabet)

#Fonction César
def Cesar(texte, nombre, option):
    nombre_crypt = 0
    nouveau_texte = ""
    upper = 0
    #print(nombre)
    for x in texte :
        #print(Alphabet.get(x[0]))
        if x.isupper():
            x=x.lower()
            upper = 1
        if option == "1":
            if nombre / Alphabet.get(x[0]) > 1:
                nombre -= 26
            nombre_crypt = (Alphabet.get(x[0]) - nombre)
        if option == "0" :
            nombre_crypt = (Alphabet.get(x[0]) + nombre)%26
        if nombre_crypt == 0:
            nombre_crypt = 26
        for lettre, index in Alphabet.items():
            if index == nombre_crypt :
                if upper == 1:
                    lettre=lettre.upper()
                    upper = 0
                nouveau_texte += lettre
    return nouveau_texte


#Fonction pour itérer la clef sur la longueur du texte à coder
def clef_adaptee(texte,clef):
    clef_adaptee = clef * int((lt/lc)) + clef[:(lt%lc)]
    return clef_adaptee

#Fonction finale
def Vigenere(texte,clef,option):
    encrypt_text=""
    i=0
    ca = clef_adaptee(texte,clef)
    while i < lt :
        encrypt_text += Cesar(texte[i],Alphabet.get(ca[i])-1, option)
        i += 1
    return encrypt_text

#Fonction de traitement d'entrées (pas d'espaces)
def space_killer(texte):
    t=""
    for x in texte:
        if x.isspace() :
          x=""
        t += x
    return t

#Fonction de traitement d'entrées (que des lettres)
def only_alpha(clef):
    alphacheck = 0
    while alphacheck == 0 :
        alphawrong = 0
        for char in clef:
            if char.isalpha() == False:
                alphawrong = 1
        if alphawrong == 0:
            alphacheck = 1
    return clef.lower()


#Fonction normale ou inverse ?
option = -1
while option != "1" and option != "0" :
    option = input("Pour chiffrer tapez 0, pour déchiffrer tapez 1 :")

#Saisie et pré-traitement du texte à coder
conclusions=""
if option == "1":
    texte = input("Ce que vous voulez déchiffrer :")
    conclusion = "Le déchiffrement donne :"
if option == "0":
    texte = input("Ce que vous voulez chiffrer :")
    conclusion = "Le chiffrement donne :"
texte = space_killer(texte)
lt = len(texte)

#Saisie et pré-traitement de la clé de codage
clef = input("Votre clé de chiffrement (que des lettres sans espace svp):")
clef = only_alpha(clef)
lc = len(clef)


#Appel de fonction
print(conclusion, Vigenere(texte,clef, option))
