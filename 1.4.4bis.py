texte = ""
check = texte
def def_varInt(texte):
	byte = int(texte[:2], 16)

	if byte < 0xfd:
		return 1, byte
	elif byte == 0xfd:
		return 3, int(petitEndien(texte[2:6]), 16)
	elif byte == 0xfe:
		return 5, int(petitEndien(texte[2:10]), 16)
	elif byte == 0xff:
		return 9, int(petitEndien(texte[2:18]), 16)

def petitEndien(texte):
	r = ""
	for i in range(0, len(texte), 2):
		r = texte[i:i+2] + r
	return r

print("\n*******************TRANSACTION***********************************\n")

print(texte)

print("\n*******************VERSION***********************************\n")

print("Version:", texte[:8])
texte = texte[8:]
if len(texte)%2 == 1:
    texte = "0" + texte

byte0 = def_varInt(texte)
temp0 = byte0[0]
i = 1
while i <= byte0[1] :
        print("\n*******************INPUT n°",i,"***********************************\n")
        print("Le hash n°",i," :", texte[2*temp0:64+2*temp0])
        print("Index de la sortie n°",i,":", texte[64+2*temp0:72+2*temp0])
        ScriptSig_byte = texte[72+2*temp0:]
        byte1 = def_varInt(ScriptSig_byte)
        byte11 = def_varInt(ScriptSig_byte[2*byte1[0]:])
        ScriptSig_texte = ScriptSig_byte[2*byte1[0]+2*byte11[0]:]
        print("ScriptSig n°",i,":",ScriptSig_texte[: 2*byte11[1]])
        ScriptKey_byte = ScriptSig_texte[2*byte11[1]:]
        byte12 = def_varInt(ScriptKey_byte)
        ScriptKey_texte = ScriptKey_byte[2*byte12[0]:]
        print("ScriptKey n°",i,":",ScriptKey_texte[: 2*byte12[1]])
        print("Séquence n°",i,":", ScriptKey_texte[2 * byte12[1]: 2* byte12[1] +8 ])
        texte = ScriptKey_texte[2* byte12[1]+8:]
        temp0 = 0
        i += 1
        
        



byte2 = def_varInt(texte)
temp2 = byte2[0]
i = 1
while i <= byte2[1] :
        print("\n******************OUTPUT n°",i,"***********************************\n")
        bc = petitEndien(texte[2*temp2:2*(8+temp2)])
        print("Montant Satoshis n°",i,":", bc, "Soit : ",int(bc, 16)/100000000, "bitcoins")
        ScriptPubKey_byte =texte[2*(8+temp2):]
        byte3 = def_varInt(ScriptPubKey_byte)
        print(byte3, i)
        ScriptPubKey_texte =ScriptPubKey_byte[2*byte3[0]:]
        print("ScriptPubKey n°",i,":",ScriptPubKey_texte[: 2*byte3[1]])
        texte = ScriptPubKey_texte[2*(byte3[1]):]
        temp2 = 0
        i += 1

print("Lockime:",texte)
