var adresse
var fournisseur
async function createMetaMaskDapp() {
    const abi = [
        {
            "constant": false,
            "inputs": [
                {
                    "name": "description",
                    "type": "string"
                },
                {
                    "name": "timing",
                    "type": "uint256"
                },
                {
                    "name": "reputationMinimum",
                    "type": "uint256"
                },
                {
                    "name": "remuneration",
                    "type": "uint256"
                }
            ],
            "name": "enregistrerDemande",
            "outputs": [],
            "payable": true,
            "stateMutability": "payable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "nom",
                    "type": "string"
                }
            ],
            "name": "inscription",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "name": "demandes",
            "outputs": [
                {
                    "name": "",
                    "type": "address"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "etat",
            "outputs": [
                {
                    "name": "",
                    "type": "uint8"
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
                    "name": "reputationMinimum",
                    "type": "uint256"
                }
            ],
            "name": "filtrerCandidats",
            "outputs": [
                {
                    "name": "",
                    "type": "address[]"
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
                    "name": "",
                    "type": "uint256"
                }
            ],
            "name": "utilisateurs",
            "outputs": [
                {
                    "name": "",
                    "type": "address"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        }
    ]
    const addressContract = "0x807eeb186fe8aab7eb88290d145d9c10400c038a" //Remix #1 défi2


    try {
        // Demande à MetaMask l'autorisation de se connecter
        const addresses = await ethereum.enable()
        const user = addresses[0]

        // Connection au noeud fourni par l'objet web3
        const provider = new ethers.providers.Web3Provider(ethereum);

        //instanciation du contrat
        let marketPlace = new ethers.Contract(addressContract, abi, provider);

        //Signature
        let marketPlaceSigne = marketPlace.connect(provider.getSigner(user.address));


        /// constitution de l'objet dapp
        dapp = {
            user,
            provider,
            marketPlace,
            marketPlaceSigne
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

function displayDemands() {

    console.log(dapp.marketPlaceSigne);
    console.log(dapp.marketPlaceSigne.demandes;

        /*
    // création d'un tableau pour les résultats inputs
    var bodyInput = document.getElementsByTagName("body")[0];
    var tableInput = document.createElement('table');
    var bodyTableInput = document.createElement("tbody");
    tableInput.setAttribute('border', '1');
    tableInput.setAttribute('width', '50%');

    for (var i = 0; i < 6; i++) {
        var ligneInput = document.createElement("tr");
        console.log(dapp);
        console.log(dapp.marketPlaceSigne);
        console.log(dapp.marketPlaceSigne.demandes);


        for (var j = 0; j < dapp.marketPlaceSigne.demandes.length; j++) {
            var cellInput = document.createElement("td");
            cellInput.innerHTML = dapp.marketPlaceSigne.demandes[i][j]
            ligneInput.appendChild(cellInput);
            bodyTableInput.appendChild(ligneInput);
            tableInput.appendChild(bodyTableInput);
            bodyInput.appendChild(tableInput);
            
} */

    }
