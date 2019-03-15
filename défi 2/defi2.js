var adresse
var fournisseur
async function createMetaMaskDapp() {
    const abi = [
        {
            "constant": false,
            "inputs": [
                {
                    "name": "indDemande",
                    "type": "uint256"
                },
                {
                    "name": "indCandidat",
                    "type": "uint256"
                }
            ],
            "name": "accepterCandidat",
            "outputs": [
                {
                    "name": "",
                    "type": "address"
                }
            ],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "indDemande",
                    "type": "uint256"
                },
                {
                    "name": "comment",
                    "type": "string"
                },
                {
                    "name": "votre_note_sur_20",
                    "type": "uint8"
                }
            ],
            "name": "commenterClient",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "indDemande",
                    "type": "uint256"
                },
                {
                    "name": "comment",
                    "type": "string"
                },
                {
                    "name": "votre_note_sur_20",
                    "type": "uint8"
                }
            ],
            "name": "commenterIllustrateur",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
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
            "constant": false,
            "inputs": [
                {
                    "name": "indDemande",
                    "type": "uint256"
                },
                {
                    "name": "travaux",
                    "type": "bytes32"
                }
            ],
            "name": "livraisonIllustration",
            "outputs": [],
            "payable": true,
            "stateMutability": "payable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "index",
                    "type": "uint256"
                }
            ],
            "name": "postulerDemande",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "indDemande",
                    "type": "uint256"
                }
            ],
            "name": "refusIllutration",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "indDemande",
                    "type": "uint256"
                }
            ],
            "name": "retard",
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
                    "name": "description",
                    "type": "string"
                },
                {
                    "name": "etat",
                    "type": "uint8"
                },
                {
                    "name": "repMin",
                    "type": "uint256"
                },
                {
                    "name": "remuneration",
                    "type": "uint256"
                },
                {
                    "name": "illustrator",
                    "type": "address"
                },
                {
                    "name": "emetteur",
                    "type": "address"
                },
                {
                    "name": "hashUrl",
                    "type": "bytes32"
                },
                {
                    "name": "acceptationDate",
                    "type": "uint256"
                },
                {
                    "name": "deliveryTime",
                    "type": "uint256"
                },
                {
                    "name": "deliveryDate",
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
                    "name": "i",
                    "type": "uint256"
                }
            ],
            "name": "getNbCandidat",
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
            "inputs": [],
            "name": "getNbDemande",
            "outputs": [
                {
                    "components": [
                        {
                            "name": "description",
                            "type": "string"
                        },
                        {
                            "name": "etat",
                            "type": "uint8"
                        },
                        {
                            "name": "repMin",
                            "type": "uint256"
                        },
                        {
                            "name": "remuneration",
                            "type": "uint256"
                        },
                        {
                            "name": "candidats",
                            "type": "address[]"
                        },
                        {
                            "name": "illustrator",
                            "type": "address"
                        },
                        {
                            "name": "emetteur",
                            "type": "address"
                        },
                        {
                            "name": "hashUrl",
                            "type": "bytes32"
                        },
                        {
                            "name": "acceptationDate",
                            "type": "uint256"
                        },
                        {
                            "name": "deliveryTime",
                            "type": "uint256"
                        },
                        {
                            "name": "deliveryDate",
                            "type": "uint256"
                        }
                    ],
                    "name": "",
                    "type": "tuple[]"
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
                    "type": "address"
                }
            ],
            "name": "indexDemande",
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
            "inputs": [],
            "name": "nbDemande",
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
            "inputs": [],
            "name": "nbUtilisateur",
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
                    "name": "",
                    "type": "uint256"
                }
            ],
            "name": "utilisateurs",
            "outputs": [
                {
                    "name": "rep",
                    "type": "uint256"
                },
                {
                    "name": "nom",
                    "type": "string"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        }
    ]
    const addressContract = "0xe2c4ee4a2320bbb430aa93a4a01270d2fb9b69df" //Remix #1 défi2


    try {
        // Demande à MetaMask l'autorisation de se connecter
        const addresses = await ethereum.enable()
        const user = addresses[0]

        // Connection au noeud fourni par l'objet web3
        const provider = new ethers.providers.Web3Provider(ethereum);

        //instanciation du contrat
        let marketPlace = new ethers.Contract(addressContract, abi, provider);

        //Signature
        marketPlace = marketPlace.connect(provider.getSigner(user.address));


        /// constitution de l'objet dapp
        dapp = {
            user,
            provider,
            marketPlace,
        };

        
        console.log("dapp ok: ", await dapp);
        //html
        document.getElementById("adr").innerHTML = dapp.user.toString();
        document.getElementById("prov").innerHTML = dapp.marketPlace.address.toString();

        return dapp

    } catch (err) {
        // Gestion des erreurs
        console.error(err);
    }
  
}


async function displayDemands() {

    try{
        document.getElementById("demande").innerHTML = "";
    }finally{
        console.log("refresh");
    }
    

    try {
    let demandes =  await dapp.marketPlace.getNbDemande();
    // create fragment
    const f = document.createDocumentFragment();
    // loop offers
    
    if(demandes.length > 0) {
        let tableau = `
            <table class="table container-fluid">
           <thead>
             <tr>
               <th scope="col">#</th>
               <th scope="col">Description</th>
               <th scope="col">Reputation minimum</th>
               <th scope="col">Remuneration</th>
               <th scope="col">Time limit</th>
               <th scope="col">Candidats</th>
               <th scope="col">Statut</th>
               <th scope="col">Emetteur</th>
               <th scope="col">Illustrateur</th>
               <th scope="col">Réservé aux illustrateurs</th>
               <th scope="col">Réservé aux entreprises</th>
             </tr>
           </thead>`

    for(x of demandes) {
            cand = document.createElement("div");
            for(c of x.candidats){  
                cand.innerHTML += c + "<br>" ;  
            }
          alert(tableau)
                tableau +=
           `<tbody>
             <tr>
               <th scope="row">${demandes.indexOf(x)}</th>
               <td>${x.description}</td>
               <td>${x.repMin}</td>
               <td>${x.remuneration}</td>
               <td>${x.deliveryTime}</td>
               <td>${cand.outerHTML}</td>
               <td>${x.etat}</td>
               <td>${x.emetteur}</td>
               <td>${x.illustrator}</td>
               <td><button onclick="postuler(${demandes.indexOf(x)})">Concourir</td>
               <td>
               <span><button onclick="postuler(${demandes.indexOf(x)})">Pénaliser un retard</span><br>
               <span><button onclick="postuler(${demandes.indexOf(x)})">Accepter illustration</span>
               </td>
             </tr>
           </tbody>`
        }
            tableau += `</table>`;
            doc = document.createElement("div");
            doc.innerHTML = tableau;
            f.appendChild(doc);
            document.getElementById("demande").appendChild(f);
        
        } else {
            doc.innerHTML = "Désolée, il n'y a pas d'offres pour le moment.";
            f.appendChild(doc);
            document.getElementById("demande").appendChild(f);

    }
    
    console.log(demandes);
} catch (err) {
    // Gestion des erreurs
    alert(err)
    console.error(err);
}
}

async function postuler(indexDemande){
    try{
    let list = await (dapp.marketPlace.postulerDemande(indexDemande));
    alert("Vous avez bien posulé à la demande", indexDemande)
    }catch (err) {
        // Gestion des erreurs
        alert("Vous n'avez pas la réputation suffisante pour postuler à cette offre")
        console.error(err);

}
}
 
