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
nombre_crypt = 0
nouveau_texte = ""
upper = 0

texte = input("Ce que vous voulez chiffrer :")
nombre = -1
while nombre < 0 :
    try:
        nombre = int(input("Tapez votre clé de cryptographie (entier positif ou nul) : "))
    except ValueError:
        print("Vous n'avez pas saisi de nombre")


for x in texte :
    
    if x.isspace() :
        nouveau_texte += x
    else:
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

print(nouveau_texte)
