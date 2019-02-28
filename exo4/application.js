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

async function balanc2e() {
    dapp.provider.getBalance(dapp.address).then((balance) => {
        let etherString = ethers.utils.formatEther(balance);
        console.log("Balance: " + etherString);
    });
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
