var adresse
var fournisseur
async function createMetaMaskDapp() {
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
    const addressContract = "0x451875bdd0e524882550ec1ce52bcc4d0ff90eae"


    try {
        // Demande à MetaMask l'autorisation de se connecter
        const addresses = await ethereum.enable()
        const user = addresses[0]

        // Connection au noeud fourni par l'objet web3
        const provider = new ethers.providers.Web3Provider(ethereum);

        //instanciation du contrat
        let contratCredibilite = new ethers.Contract(addressContract, abi, provider);

        //Signature
        let contratCredibiliteSigne = contratCredibilite.connect(provider.getSigner(user.address));


        /// constitution de l'objet dapp
        dapp = {
            user,
            provider,
            contratCredibilite,
            contratCredibiliteSigne
        };
        console.log("DApp ready: ", dapp)


        //html
        document.getElementById("adr").innerHTML = dapp.user.toString();
        document.getElementById("prov").innerHTML = dapp.provider.connection.url;
        return dapp

    } catch (err) {
        // Gestion des erreurs
        console.error(err);
    }
}


async function balance() {
    if (dapp.user) {
        dapp.provider.getBalance(dapp.user).then((bal) => {
            let etherString = ethers.utils.formatEther(bal);
            console.log("Balance :" + etherString);
            document.getElementById("balance").innerHTML = etherString;
        })
    } else {
        alert("Merci de vous connecter avec le metamask d'abord.")
    }
}


async function numeroBloc() {
    if (dapp.user) {
        dapp.provider.getBlockNumber().then((numeroBloc) => {
            console.log("Numéro du bloc :" + numeroBloc)
            document.getElementById("bloc").innerHTML = numeroBloc;
        })
    } else {
        alert("Merci de vous connecter avec le metamask d'abord.")
    }
}

async function prixDuGas() {
    if (dapp.user) {
        dapp.provider.getGasPrice().then((prixDuGaz) => {
            console.log("Prix du gaz :" + prixDuGaz)
            document.getElementById("gaz").innerHTML = prixDuGaz;
        })
    } else {
        alert("Merci de vous connecter avec le metamask d'abord.")
    }
}

async function remettreDevoir() {
    if (dapp.user) {

        //dépôt du devoir
        var devoir = document.getElementById("devoir").value;
        devoir = await dapp.contratCredibiliteSigne.produireHash(devoir);

        //récupération des cred
        let maCredibilite = await dapp.contratCredibiliteSigne.cred(dapp.user);

        // calcul du rang de remise du devoir et de la crédibilité obtenue
        dapp.contratCredibiliteSigne.remettre(devoir).then((rank) => {
            if (rank.value < 4) {
                maCredibilite += (40 - rank.value * 10);
            } else {
                maCredibilite += 10;
            }
            ///html
            document.getElementById("devoirRemis").innerHTML = "Devoir remis, merci !";
            document.getElementById("rank").innerHTML = rank.value; //0 (?)
            document.getElementById("cred").innerHTML = maCredibilite;
        })

    } else {
        alert("Merci de vous connecter avec le metamask d'abord.")
    }
}
