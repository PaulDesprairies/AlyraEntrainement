header = "0x1c0ae493"
cible_max=((2**16)-1)*(2**208)

exp = int(header[:4],16)
coeff = hex(int(header[4:],16))
coeff = str(coeff)

def extract_cible(data):
    i = 0
    while i < 2 * exp - 6:
        data = data + "0"
        i = i+1
    return data

difficulte = cible_max/int(extract_cible(coeff),16)
print(difficulte, "&", int(extract_cible(coeff),16))
