n= 643
print(hex(n))

def conversion(n):
    grandEndien = hex(n)
    grandEndien = grandEndien[2:len(grandEndien)]
    a=""
    i=0
    petitEndien = ""

    if len(grandEndien)%2 == 0:
        for x in grandEndien :
            if i%2 == 1:
                petitEndien = a+x + petitEndien
            a=x
            i+=1
        petitEndien = "0x" + petitEndien
        grandEndien = "0x" + grandEndien
    else :
        for x in grandEndien :
            if i%2 == 0:
                petitEndien = a+x + petitEndien
            a=x
            i+=1
        petitEndien = "0x" + petitEndien
        petitEndien = petitEndien[0:len(petitEndien)-1] + "0" + petitEndien[-1]
        grandEndien = "0x0" + grandEndien
        
    print(grandEndien, petitEndien)

conversion(n)
