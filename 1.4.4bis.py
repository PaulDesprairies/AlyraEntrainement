texte = "0100000001c997a5e56e104102fa209c6a852dd90660a20b2d9c352423edce25857fcd3704000000004847304402204e45e16932b8af514961a1d3a1a25fdf3f4f7732e9d624c6c61548ab5fb8cd410220181522ec8eca07de4860a4acdd12909d831cc56cbbac4622082221a8768d1d0901ffffffff0200ca9a3b00000000434104ae1a62fe09c5f51b13905f07f06b99a2f7159b2225f374cd378d71302fa28414e7aab37397f554a7df5f142c21c1b7303b8a0626f1baded5c72a704f7e6cd84cac00286bee0000000043410411db93e1dcdb8a016b49840f8c53bc1eb68a382e97b1482ecad7b148a6909a5cb2e0eaddfb84ccf9744464f82e160bfa9b8b64f9d4c03f999b8643f656b412a3ac00000000"
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
