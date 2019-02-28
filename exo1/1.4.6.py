ops = {
    "+": (lambda a, b: a + b),
    "-": (lambda a, b: a - b),
    "*": (lambda a, b: a * b),
    "/": (lambda a, b: a / b),
    ">": (lambda a, b: a > b),
    "<": (lambda a, b: a < b)
}

def calculer(chaine):
    elements = chaine.split()
    res = []

    for e in elements:
        #print(res)
        if e in ops:
            b = res.pop()
            #print(a)
            a = res.pop()
            #print(b)
            result = ops[e](a, b)
            res.append(result)
        else:
            res.append(int(e))

    return res.pop()
  
print(calculer("12 4 - 2 <"))

