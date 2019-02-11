texte = "0100000001f129de033c57582efb464e94ad438fff493cc4de4481729b85971236858275c2010000006a4730440220155a2ea4a702cadf37052c87bfe46f0bd24809759acff8d8a7206979610e46f6022052b688b784fa1dcb1cffeef89e7486344b814b0c578133a7b0bce5be978a9208012103915170b588170cbcf6380ef701d19bd18a526611c0c69c62d2c29ff6863d501affffffff02ccaec817000000001976a9142527ce7f0300330012d6f97672d9acb5130ec4f888ac18411a000000000017a9140b8372dffcb39943c7bfca84f9c40763b8fa9a068700000000"
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
print(byte0)
i = 1
while i <= byte0[0] :
        print("\n*******************INPUT n°",i,"***********************************\n")
        print("Le hash n°",i," :", texte[2*byte0[0]:64+2*byte0[0]])
        print("Index de la sortie n°",i,":", texte[64+2*byte0[0]:72+2*byte0[0]])
        ScriptSig_byte = texte[72+2*byte0[0]:]
        byte1 = def_varInt(ScriptSig_byte)
        byte11 = def_varInt(ScriptSig_byte[2:])
        ScriptSig_texte = ScriptSig_byte[2*byte1[0]+2*byte11[0]:]
        print("ScriptSig n°",i,":",ScriptSig_texte[: 2*byte11[1]])
        ScriptKey_byte = ScriptSig_texte[2*byte11[1]:]
        byte12 = def_varInt(ScriptKey_byte)
        ScriptKey_texte = ScriptKey_byte[2*byte12[0]:]
        print("ScriptKey n°",i,":",ScriptKey_texte[: 2*byte12[1]])
        print("Séquence n°",i,":", ScriptKey_texte[2 * byte12[1]: 2* byte12[1] +8 ])
        texte = ScriptKey_texte[2* byte12[1]+8:]
        i = i +1
        



byte2 = def_varInt(texte)

i = 1
while i <= byte2[0] :
        print("\n******************OUTPUT n°",i,"***********************************\n")
        print("Montant Satoshis n°",i,":", texte[byte2[0]:8+byte2[0]], "Soit : ",int(texte[byte2[0]:8+byte2[0]], 16)/100000000, "bitcoins")
        ScriptPubKey_byte =texte[8+byte2[0]:]
        byte3 = def_varInt(ScriptPubKey_byte)
        ScriptPubKey_texte =ScriptPubKey_byte[2*byte3[0]:]
        print("ScriptPubKey n°",i,":",ScriptPubKey_texte[: 2*byte3[1]])
        texte = ScriptPubKey_texte[: 2*byte3[1]]
        i = i + 1
if check[-20:] == ScriptPubKey_texte[-20:] :
        print("check ok")
else :
        print("check not ok")
