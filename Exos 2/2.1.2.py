header = "0x1c0ae493"
cible_max=((2**16)-1)*(2**208)

zeroing = int(header[:4],16)
cible = hex(int(header[4:],16))
cible = str(cible)

def extract_cible(data):
    i = 0
    while i < 2 * zeroing - 6:
        data = data + "0"
        i = i+1
    return data

difficulte = cible_max/int(extract_cible(cible),16)
print(difficulte)
