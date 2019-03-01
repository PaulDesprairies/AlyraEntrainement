var adresse
var fournisseur


async function createMetaMaskDapp() {
    try {
        // Demande à MetaMask l'autorisation de se connecter
        const addresses = await ethereum.enable();
        const address = addresses[0]
        // Connection au noeud fourni par l'objet web3
        const provider = new ethers.providers.Web3Provider(ethereum);
        dapp = {
            address,
            provider
        };
        console.log(dapp)
        adresse = dapp.address;
        fournisseur = dapp.provider;

        document.getElementById("adr").innerHTML = dapp.address.toString();
        document.getElementById("prov").innerHTML = "bien là";


    } catch (err) {
        // Gestion des erreurs
        console.error(err);
    }
}


async function balance() {
    if (adresse) {
        fournisseur.getBalance(adresse).then((balance) => {
            let etherString = ethers.utils.formatEther(balance);
            console.log("Balance :" + etherString);
            document.getElementById("balance").innerHTML = etherString;
        })
    } else {
        alert("Merci de vous connecter avec le metamask d'abord.")
    }

}


async function numeroBloc() {
    if (adresse) {
        fournisseur.getBlockNumber().then((numeroBloc) => {
            console.log("Numéro du bloc :" + numeroBloc)
            document.getElementById("bloc").innerHTML = numeroBloc;
        })
    } else {
        alert("Merci de vous connecter avec le metamask d'abord.")
    }
}

async function prixDuGas() {
    if (adresse) {
        fournisseur.getGasPrice().then((prixDuGaz) => {
            console.log("Prix du gaz :" + prixDuGaz)
            document.getElementById("gaz").innerHTML = prixDuGaz;
        })
    } else {
        alert("Merci de vous connecter avec le metamask d'abord.")
    }
}

async function remettreDevoir() {
    if (adresse) {
        const abi = [
            {
                "constant": false,
                "inputs": [
                    {
                        "name": "dev",
                        "type": "bytes32"
      }
    ],
                "name": "remettre",
                "outputs": [
                    {
                        "name": "",
                        "type": "uint256"
      }
    ],
                "payable": false,
                "stateMutability": "nonpayable",
                "type": "function"
  },
            {
                "constant": true,
                "inputs": [
                    {
                        "name": "",
                        "type": "address"
      }
    ],
                "name": "cred",
                "outputs": [
                    {
                        "name": "",
                        "type": "uint256"
      }
    ],
                "payable": false,
                "stateMutability": "view",
                "type": "function"
  },
            {
                "constant": true,
                "inputs": [
                    {
                        "name": "dd",
                        "type": "string"
      }
    ],
                "name": "produireHash",
                "outputs": [
                    {
                        "name": "",
                        "type": "bytes32"
      }
    ],
                "payable": false,
                "stateMutability": "pure",
                "type": "function"
  },
            {
                "constant": false,
                "inputs": [
                    {
                        "name": "destinataire",
                        "type": "address"
      },
                    {
                        "name": "valeur",
                        "type": "uint256"
      }
    ],
                "name": "transfer",
                "outputs": [],
                "payable": false,
                "stateMutability": "nonpayable",
                "type": "function"
  }
]
        addressContract = "0x451875bdd0e524882550ec1ce52bcc4d0ff90eae"
        let contratCredibilite = new ethers.Contract(addressContract, abi, fournisseur);

        //dépôt du devoir
        var devoir = document.getElementById("devoir").value
        devoir = await contratCredibilite.produireHash(devoir);

        var rank = await contratCredibilite.remettre(devoir);
        //calcul de la crédibilité obtenue
        let maCredibilite = await contratCredibilite.cred(adresse)
        if (rank < 4) {
            maCredibilite += 40 - rank * 10;
        } else {
            maCredibilite += 10;
        }
        return maCredibilite;

        document.getElementById("devoirRemis").innerHTML = "Merci !";
        document.getElementById("cred").innerHTML = maCredibilite;

    } else {
        alert("Merci de vous connecter avec le metamask d'abord.")
    }
}
