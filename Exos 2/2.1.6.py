somme = 0
p = 0
height = 562679

def blocReward(height):
    palier = int(height/210000)
    reward = int((50 / (2**palier)) * 100000000)
    return palier, reward


def total_bc(height):
    somme = blocReward(height)[1] * ((height%210000)+1)
    p = blocReward(height)[0]
    while p > 0 :
        print(p)
        p -=1
        somme = somme + (int((50 / (2**p)) * 210000 * 100000000))
    return somme / 100000000

print(total_bc(height))
