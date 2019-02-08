texte = "0100000001f129de033c57582efb464e94ad438fff493cc4de4481729b85971236858275c2010000006a4730440220155a2ea4a702cadf37052c87bfe46f0bd24809759acff8d8a7206979610e46f6022052b688b784fa1dcb1cffeef89e7486344b814b0c578133a7b0bce5be978a9208012103915170b588170cbcf6380ef701d19bd18a526611c0c69c62d2c29ff6863d501affffffff02ccaec817000000001976a9142527ce7f0300330012d6f97672d9acb5130ec4f888ac18411a000000000017a9140b8372dffcb39943c7bfca84f9c40763b8fa9a068700000000"


def separation_entree_sortie(texte):
    i = 0
    indx = 0
    for x in texte:
        if x == "f":
            i += 1
        else :
            i = 0
        indx +=1
        if i == 8 :
            #print("l'index de séparation entrée/sortie est", indx)
            break
    return indx

def decomposition_version(texte):
    print("Version :",texte[:8])
    

def decomposition_input(texte):
    subHash = texte[0:64]
    subIndex  =  texte[64:72]
    subScriptSig = texte[72:-8]
    subSequence  = texte[-8:]

    print("Input / Hash :",subHash)
    print("Input / Index :",subIndex)
    print("Input / ScriptSid :",subScriptSig)
    print("Input / Sequence :",subSequence)


def decomposition_output(texte):
    subNbSorties = texte[0:2]
    subMontant = texte[2:18]
    subTailleScript = texte[18:20]
    subScriptPubKey = texte[20:]

    print("Output / Nombre de sorties :",subNbSorties)
    print("Output / Montant :",subMontant)
    print("Output / Taile du script :",subTailleScript)
    print("Output / ScriptPubKey :",subScriptPubKey)
    

def decomposition_locktime(texte):
    print("Locktime :",texte[-8:])
    

def decomposition(texte):
    print("\n*********************VERSION******************************\n")

    decomposition_version(texte)

    print("\n**********************INPUT*****************************\n")

    #entrée
    entree = texte[8:separation_entree_sortie(texte)]
    decomposition_input(entree)

    print("\n***********************OUTPUT*****************************\n")

    #sortie
    sortie = texte[separation_entree_sortie(texte):-8]
    decomposition_output(sortie)


    print("\n***********************LOCKTIME****************************\n")
    

    #locktime
    decomposition_locktime(texte)

    print("\n************************E N D****************************\n")

#    if len(texte)==(len(texte[:8])+len(subHash)+len(subIndex)+len(subScriptSig)+len(subSequence)+len(subNbSorties)+len(subMontant)+len(texte[:8])+len(subScriptPubKey)+len(subTailleScriptPubKey)+len(subTailleScript))
#        print("True")
#    else:
#        print("False")

#appel de fonction
decomposition(texte)
