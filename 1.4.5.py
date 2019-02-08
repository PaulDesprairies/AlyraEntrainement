ops = {
    "+": (lambda a, b: a + b),
    "-": (lambda a, b: a - b),
    "*": (lambda a, b: a * b),
    "/": (lambda a, b: a / b)
}

def calculer(chaine):
    elements = chaine.split()
    res = []

    for e in elements:
        #print(res)
        if e in ops:
            a = res.pop()
            #print(a)
            b = res.pop()
            #print(b)
            result = ops[e](b, a)
            res.append(result)
        else:
            res.append(int(e))

    return res.pop()
  
print(calculer("12 4 - 2 *"))
