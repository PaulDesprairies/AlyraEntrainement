texte = "1941e985075825e09de53b08cdd346bb67075ef0ce5c94f98853292d4bf94c10d010000006b483045022100ab44ef425e6d85c03cf301bc16465e3176b55bba9727706819eaf07cf84cf52d02203f7dc7ae9ab36bead14dd3c83c8c030bf8ce596e692021b66441b39b4b35e64e012102f63ae3eba460a8ed1be568b0c9a6c947abe9f079bcf861a7fdb2fd577ed48a81Feffffff"
if len(texte)%2 == 1:
    texte = "0" + texte


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


print(texte)
byte0 = def_varInt(texte)
print("VarInt0", byte0)
print("Nombre d'Inputs :",byte0[1])
print("Le hash :", texte[2*byte0[0]:64+2*byte0[0]], "/ longueur du hash :", len(texte[2*byte0[0]:64+2*byte0[0]]))
print("Index de la sortie:", texte[64+2*byte0[0]:72+2*byte0[0]], "/ longueur de l'index :", len(texte[64+2*byte0[0]:72+2*byte0[0]]))
ScriptSig_texte = texte[72+2*byte0[0]:]
byte1 = def_varInt(ScriptSig_texte)
print("ScriptSig:",ScriptSig_texte[2*byte1[0]:2*byte1[0] + byte1[1]], "/ longueur du ScriptSig:", byte1[1])
print("Séquence:", ScriptSig_texte[2*byte1[0] + byte1[1]:2*byte1[0] + byte1[1] +8 ])

print("Restant (ne comprend pas):", ScriptSig_texte[2*byte1[0] + byte1[1] +8:])

