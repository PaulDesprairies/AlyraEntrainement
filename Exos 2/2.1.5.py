def blocReward(height):
    palier = int(height/210000)
    reward = int((50 / (2**palier))) * 100000000)
    print(palier)
    return reward

height = 550000000000000
print(blocReward(height))
