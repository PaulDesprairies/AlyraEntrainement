n= 466321
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

    if n < 253 :
        print(grandEndien, petitEndien, "Pas de varInt")

    else :
        l = (len(petitEndien)/2) - 1
        print(grandEndien, petitEndien)
        varInt = petitEndien[2:len(petitEndien)]
        if l == 1:
            varInt = "0xfd" + varInt + "00"
        elif l == 2:
            varInt = "0xfd" + varInt
        elif l == 3 :
            varInt = "0xfe" + varInt + "00"
        elif l == 4 :
            varInt = "0xfe" + varInt
        elif l > 4 :
            varInt = "0xff" + varInt
            while l < 8 :
                varInt = varInt + "00"
                l +=1

        print(grandEndien, petitEndien, varInt)
    




conversion(n)
