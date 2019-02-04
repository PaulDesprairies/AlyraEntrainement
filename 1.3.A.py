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
def Cesar(texte, nombre):
    nombre_crypt = 0
    nouveau_texte = ""
    upper = 0

    for x in texte :
        if x.isupper():
            x=x.lower()
            upper = 1

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
def Vigenere(texte,clef):
    encrypt_text=""
    i=0
    ca = clef_adaptee(texte,clef)
    while i < lt :
        encrypt_text += Cesar(texte[i],Alphabet.get(ca[i])-1)
        i += 1
    print(encrypt_text)

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


#Saisie et pré-traitement du texte à coder
texte = input("Ce que vous voulez chiffrer :")
texte = space_killer(texte)
lt = len(texte)

#Saisie et pré-traitement de la clé de codage
clef = input("Votre clé de chiffrement (que des lettres sans espace svp):")
clef = only_alpha(clef)
lc = len(clef)


#Appel de fonction
Vigenere(texte,clef)
