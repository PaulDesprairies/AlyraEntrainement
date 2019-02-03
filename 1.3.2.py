texte = input("Entrez votre texte ici :")

def frequences(texte):
    couple=""
    string=""
    res=[]
    for x in texte:
        match = 0
        for y in texte :
            if y == x :
               match += 1
        res.append([x[0], match])
    res = dict(sorted(res))

    for a in res:
        couple = "    " + str(res.get(a)) + " " + a
        string = string + couple
    print(string)

frequences(texte)
