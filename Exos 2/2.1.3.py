def blocReajustement(height):
    return height%2016 == 0

height = 556416
print(blocReajustement(height))
