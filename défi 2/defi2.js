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
                }
            ],
            "name": "refusIllutration",
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
            "name": "utilisateurs",
            "outputs": [
                {
                    "name": "rep",
                    "type": "uint256"
                },
                {
                    "name": "nom",
                    "type": "string"
                },
                {
                    "name": "addresse",
                    "type": "address"
                },
                {
                    "name": "admin",
                    "type": "bool"
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
            "constant": false,
            "inputs": [
                {
                    "name": "indUtilisateur",
                    "type": "uint256"
                }
            ],
            "name": "expulser",
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
                    "name": "indUtilisateur",
                    "type": "uint256"
                }
            ],
            "name": "promouvoir",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
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
            "name": "getNbUtilisateur",
            "outputs": [
                {
                    "components": [
                        {
                            "name": "rep",
                            "type": "uint256"
                        },
                        {
                            "name": "nom",
                            "type": "string"
                        },
                        {
                            "name": "commentaires",
                            "type": "string[]"
                        },
                        {
                            "name": "addresse",
                            "type": "address"
                        },
                        {
                            "name": "satisfaction",
                            "type": "uint8[]"
                        },
                        {
                            "name": "admin",
                            "type": "bool"
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
            "inputs": [
                {
                    "name": "nom",
                    "type": "string"
                }
            ],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "constructor"
        }
    ]

    const addressContract = "0x73254accae4ad8f23ca18c5009f00d127ed108ec" //Remix #1 défi2


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
        let identiteVous = "<br>Vous êtes " + dapp.user.toString();
        document.getElementById("adr").innerHTML = identiteVous;
        dapp.marketPlace.addressPromise.then(function(value) {
            value = value.toLowerCase();
        let identiteContrat = "Vous interagissez avec le contrat " + value + "<br>";
        document.getElementById("prov").innerHTML = identiteContrat;
        });

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

    document.getElementById("demande").innerHTML = "Veuillez patienter...";
    await createMetaMaskDapp() 

    try {
    let demandes =  await dapp.marketPlace.getNbDemande();
    // create fragment
    const f = document.createDocumentFragment();
    // loop offers
    
    
        let tableau = `
            <table class="table">
           <thead class="thead-dark">
             <tr>
               <th scope="col" class="text-center">Demande #</th>
               <th scope="col" class="text-center">Description</th>
               <th scope="col" class="text-center">Reputation minimum</th>
               <th scope="col" class="text-center">Remuneration (ethers)</th>
               <th scope="col" class="text-center">_____Délai_______</th>
               <th scope="col" class="text-center">Candidats en lice pour le projet</th>
               <th scope="col" class="text-center">Statut</th>
               <th scope="col" class="text-center">Entreprise emettrice</th>
               <th scope="col" class="text-center">Illustrateur choisi par l'entreprise</th>
               <th scope="col" class="text-center">Hash de l'illustration</th>
               <th scope="col" class="text-center">___Entreprises___</th>
             </tr>
           </thead>`
           let index;
    if(demandes.length > 0) {
        for(x of demandes) {
            index = demandes.indexOf(x);
            cand = document.createElement("div");
            //let i = 0; 
            for(c of x.candidats){ 
                cand.innerHTML += c.toLowerCase() + "<br>" ; 
                //i ++; 
            }
            cand.innerHTML += `<td>
            <div style="display:inline-block"><button onclick="postuler(${index})" class="btn btn-info">Concourir</div>
            <div style="display:inline-block"><button onclick="accepter(${index} )" class="btn btn-info">Choisir un candidat</div>
            </td>` ;


                tableau +=
           `<tbody class="thead-light">
             <tr>
               <th scope="row" class="text-center">${index}</th>
               <td align="center">${x.description}</td>
               <td align="center">${x.repMin}</td>
               <td align="center">${x.remuneration / 1000000000 } ethers</td>
               <td align="center">${x.deliveryTime} jours</td>
               <td align="center">${cand.outerHTML}</td>
               <td align="center">${conversionStatut(x.etat)}</td>
               <td align="center">${x.emetteur}
               <div id="commentEntreprise">
                    <button onclick="commenterEntreprise(${index})" class="btn btn-success">Laisser un commentaire à l'entreprise
               </div></td>
               <td align="center">${x.illustrator}
               <div id="commentIllustrateur">
                    <button onclick="commenterIllustrateur(${index})" class="btn btn-success">Laisser un commentaire à l'illustrateur
               </div></td>
               <td align="center">${x.hashUrl}
               <div id="hash">
                    <button onclick="remettre(${index})" class="btn btn-success">Remettre une illustration
               </div>
               </td>
               <td>
               <div>
                    <button onclick="retard(${index})" class="btn btn-warning">Pénaliser un retard
               </div><br>
               <div>
                    <button onclick="refuser(${index})" class="btn btn-danger">Refuser une oeuvre
               </div>
               </td>
             </tr>
           </tbody>`
           
        }
    }else{
            index = 0;

        }
            tableau += `<tbody>
            <tr class="p-3 mb-2 bg-light text-dark">
              <th scope="row"><span><button onclick="soumettre(${index})" class="btn btn-warning">Soumettre un projet</span><br>
              <td><input type="text" id="desc" class="form-control" placeholder="Descript."></td>
              <td><input type="text" id="repmin" class="form-control" placeholder="Rep min"></td>
              <td><input type="text" id="rem" class="form-control" placeholder="Remunérat°"></td>
              <td><input type="text" id="timing" class="form-control" placeholder="Delai (jour)"></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              </td>
            </tr>
            <th scope="row"></th>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <tr>
            </tr>
          </tbody>
          </table>`;
            doc = document.createElement("div");
            doc.innerHTML = tableau;
            f.appendChild(doc);
            document.getElementById("demande").innerHTML = "";
            document.getElementById("demande").appendChild(f);
        
        //} else {
         //   document.getElementById("demande").innerHTML = "Enregistrez votre première offre!"
            

    
    
    console.log(demandes);
    } catch (err) {
    //Gestion des erreurs
    alert(err)
    console.error(err);
    }
}


async function postuler(indexDemande){
    try{
    let list = await (dapp.marketPlace.postulerDemande(indexDemande));
    alert("Vous avez bien potsulé à la demande")
    displayDemands()
    }catch (err) {
        // Gestion des erreurs
        alert("Vous n'avez pas le droit de postuler à cette offre")
        console.error(err);

}
}

async function soumettre(){
    let _desc = document.getElementById("desc").value;
    if (_desc ==""){
        alert("Merci de renseigner une description")
        return
    }
    let _rem = document.getElementById("rem").value;
    _rem = _rem * 1000000000;
    if(checkNumber("rem")){return;}
    let _repmin = document.getElementById("repmin").value;
    if(checkNumber("repmin")){return;}
    let _timing = document.getElementById("timing").value;
    if(checkNumber("timing")){return;}
    

    //let gasPrice = await dapp.provider.getGasPrice();
        //gasPrice = parseInt(gasPrice / 1000000000000000000);
        //alert(gasPrice);
        let charge = _rem * 102/100; //+ gasPrice;
    charge = charge.toString();
    if (confirm("Vous allez être chargé(e) de " + charge + " gwei, on continue ?")) {

    } else {
        alert("Operation abandonnée")
        return
    }
    console.log(charge);
    let overrides = {
            // The maximum units of gas for the transaction to use
        gasLimit: 3000000,
        value: ethers.utils.parseUnits(charge, "gwei"),
      }
      
      console.log(_rem);

      try{
        let tx = await dapp.marketPlace.enregistrerDemande( _desc, _timing, _repmin, _rem, overrides);
        console.log(tx);
        alert("Vous avez bien enregistré votre demande");
        //setTimeout(displayDemands(), 12000);

      }catch (err) {
        console.log(tx)
        // Gestion des erreurs
        alert("Ouuups")
        console.error(err);
      

}
}


async function accepter(indexDemande){
    try{
    let _choisi = openForm("Choisissez un candidat dans la liste indiquée.");
        _choisi = _choisi.toLowerCase();
    let indCandidat = await (dapp.marketPlace.indexDemande(_choisi));
        console.log(parseInt(indCandidat));
        console.log(indexDemande);
    let list = await (dapp.marketPlace.accepterCandidat(indexDemande, parseInt(indCandidat)));
    console.log(list);
    alert("Le candidat " + list.from + " a bien été choisi");
    console.log(list);
    displayDemands()
    }catch (err) {
        // Gestion des erreurs
        alert("Opération interrompue.")
        console.error(err);

}
}

async function retard(indexDemande){
    try{
    let list = await (dapp.marketPlace.retard(indexDemande));
    alert("Votre retard a bien été enregistré sur la demande");
    displayDemands()
    }catch (err) {
        // Gestion des erreurs
        alert("Opération abandonnée")
        console.error(err);

}
}


async function remettre(indexDemande){
    try{
    let _hash = openForm("Déposez votre hash ici");
   // _hash = _hash.slice(2);
    let list = await (dapp.marketPlace.livraisonIllustration(indexDemande,_hash));
    console.log(list);
    alert("Remise enregistré.")
    displayDemands()
    }catch (err) {
        // Gestion des erreurs
        alert("Opération abandonnée")
        console.error(err);

}
}

async function commenterIllustrateur(indexDemande){
    try{
        let _comment = prompt("Laissez un commentaire à votre illustrateur.");
        let _note = prompt("Sur une échelle de 1 à 20, à combien noteriez-vous votre illustrateur ?");
        if (isNaN(_note) || _note <= 0 || _note=="" || _note > 20) {prompt("On recommence : sur une échelle de 1 à 20, à combien noteriez-vous votre illustrateur ?");}
        let list = await (dapp.marketPlace.commenterIllustrateur(indexDemande,_comment,_note));
        alert("Commentaire enregistré.")
        displayDemands()
        }catch (err) {
            // Gestion des erreurs
            alert("Opération abandonnée")
            console.error(err);
    
    }
    }

async function commenterEntreprise(indexDemande){
    try{
        let _comment = prompt("Laissez un commentaire à votre client.");
        let _note = prompt("Sur une échelle de 1 à 20, à combien noteriez-vous votre client ?");
        if (isNaN(_note) || _note <= 0 || _note=="" || _note > 20) {prompt("On recommence : sur une échelle de 1 à 20, à combien noteriez-vous votre illustrateur ?");}
        let list = await (dapp.marketPlace.commenterClient(indexDemande,_comment,_note));
        alert("Commentaire enregistré.")
        displayDemands()
        }catch (err) {
            // Gestion des erreurs
            alert("Opération abandonnée")
            console.error(err);
    
    }
    }


    async function refuser(indexDemande){
        try{
        let list = await (dapp.marketPlace.refusIllutration(indexDemande));
        alert("Votre refus a bien été enregistré sur la demande");
        displayDemands()
        }catch (err) {
            // Gestion des erreurs
            alert("Opération abandonnée")
            console.error(err);
    
    }
    }

async   function inscription(){
    await createMetaMaskDapp()
    let nom = document.getElementById("nom").value;
    if (nom.length == 0) {alert("Merci de renseigner un nom svp");return}
    try{
        await (dapp.marketPlace.inscription(nom));
        alert("Bienvenue " + nom)
    }catch (err) {
        // Gestion des erreurs
        alert("Opération abandonnée")
        console.error(err);
}
}

function conversionStatut(index){
    if(index==0){return "OUVERT"}
    if(index==1){return "EN COURS"}
    if(index==2){return "FERME"}
}
 
function checkNumber(numb) {
    var x, text;
  
    // Get the value of the input field with id="numb"
    x = document.getElementById(numb).value;
  
    // If x is Not a Number or less than one
    if (isNaN(x) || x <= 0 || x=="") {
      alert(x + ": merci de renseigner un nombre positif");
      return true
    }
        return false
  }

  function openForm(phrase) {
        var txt;
        var pk = prompt(phrase, "0x...");
        if (pk == null && pk == ""){
            alert("bye bye");

        }else if (is_hexadecimal(pk) && pk[0] == "0" && pk[1] =="x") {
            return pk

        } else {
            alert("Ceci n'est pas un hash");
            openForm(phrase)
        }  
        
    
    }

    function is_hexadecimal(str){
    str=str.slice(2);
    regexp = /^[0-9a-fA-F]+$/;
  
        if (regexp.test(str))
          {
            return true;
          }
        else
          {
            return false;

          }
    }



//////////////////////////users///////////////

    async function displayUsers() {
        try{
            document.getElementById("users").innerHTML = "";
        }finally{
            console.log("refresh");
        }
    
        document.getElementById("users").innerHTML = "Veuillez patienter...";
        await createMetaMaskDapp() 
    
        try {
        let utilisateurs =  await dapp.marketPlace.getNbUtilisateur();
        // create fragment
        const f = document.createDocumentFragment();
        // loop offers
        
        
            let tableauUsers = `
                <table class="table">
               <thead class="thead-dark">
                 <tr>
                   <th scope="col" class="text-center">Utilisateur #</th>
                   <th scope="col" class="text-center">___Nom___</th>
                   <th scope="col" class="text-center">Adresse</th>
                   <th scope="col" class="text-center">Reputation</th>
                   <th scope="col" class="text-center">Commentaires</th>
                   <th scope="col" class="text-center">Notations</th>
                   <th scope="col" class="text-center">Administrateur</th>
                   <th scope="col" class="text-center">Gestion des utilisateurs</th>
                 </tr>
               </thead>`
               //alert(utilisateurs.length)
        if(utilisateurs.length > 0) {
            for(x of utilisateurs) {
                comment = document.createElement("div");
                satisfaction = document.createElement("div");
                //let i = 0; 
                if(x.commentaires.length > 0) {
                for(c of x.commentaires){ 
                    comment.innerHTML += c.toLowerCase() + "<br>" ; 
                    //i ++; 
                }
                }else{
                    comment.innerHTML ="Aucun commentaire attribué pour le moment."  
                }
                if(x.satisfaction.length > 0) {
                for(s of x.satisfaction){ 
                    satisfaction.innerHTML += s.toLowerCase() + "<br>" ; 
                    //i ++; 
                }
                }else{
                    satisfaction.innerHTML ="Aucune note attribuée pour le moment."  
                }
            
            
   
    
    
                    tableauUsers +=
               `<tbody class="thead-light">
                <tr>
                    <th scope="row" class="text-center">${utilisateurs.indexOf(x)}</th>
                    <td align="center">${x.nom}</td>
                    <td align="center">${x.addresse}</td>
                    <td align="center">${x.rep}</td>
                    <td align="center">${comment.outerHTML}</td>
                    <td align="center">${satisfaction.outerHTML}</td>
                    <td align="center">${x.admin}</td>
                    <td>
                    <div>
                        <button onclick="promouvoir(${utilisateurs.indexOf(x)})" class="btn btn-success">Promouvoir administrateur
                    </div><br>
                    <div>
                        <button onclick="expulser(${utilisateurs.indexOf(x)})" class="btn btn-danger">Expulser de la plateforme
                    </div>
                    </td>
                </tr>
                </tbody>`
                }
            }


                tableauUsers += `<tbody>
                <tr class="p-3 mb-2 bg-light text-dark">
                  <th scope="row"><span><button onclick="inscription()" class="btn btn-warning">S'inscrire</span><br>
                  <td><input type="text" id="nom" class="form-control" placeholder="nom."></td>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                </tr>
                <th scope="row"></th>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <tr>
                </tr>
              </tbody>
              </table>`;
                doc = document.createElement("div");
                doc.innerHTML = tableauUsers;
                f.appendChild(doc);
                document.getElementById("users").innerHTML = "";
                document.getElementById("users").appendChild(f);
                
    
        
        
        console.log(utilisateurs);
    
    } catch (err) {
        //Gestion des erreurs
        alert(err)
        console.error(err);

    }
}
    
    
    
    async function postuler(indexDemande){
        try{
        let list = await (dapp.marketPlace.postulerDemande(indexDemande));
        alert("Vous avez bien potsulé à la demande")
        displayDemands()
        }catch (err) {
            // Gestion des erreurs
            alert("Vous n'avez pas le droit de postuler à cette offre")
            console.error(err);
    
    }
    }
    
    async function soumettre(){
        let _desc = document.getElementById("desc").value;
        if (_desc ==""){
            alert("Merci de renseigner une description")
            return
        }
        let _rem = document.getElementById("rem").value;
        _rem = _rem * 1000000000;
        if(checkNumber("rem")){return;}
        let _repmin = document.getElementById("repmin").value;
        if(checkNumber("repmin")){return;}
        let _timing = document.getElementById("timing").value;
        if(checkNumber("timing")){return;}
        
    
        //let gasPrice = await dapp.provider.getGasPrice();
            //gasPrice = parseInt(gasPrice / 1000000000000000000);
            //alert(gasPrice);
            let charge = _rem * 102/100; //+ gasPrice;
        charge = charge.toString();
        if (confirm("Vous allez être chargé(e) de " + charge + " gwei, on continue ?")) {
    
        } else {
            alert("Operation abandonnée")
            return
        }
        console.log(charge);
        let overrides = {
                // The maximum units of gas for the transaction to use
            gasLimit: 3000000,
            value: ethers.utils.parseUnits(charge, "gwei"),
          }
          
          console.log(_rem);
    
          try{
            let tx = await dapp.marketPlace.enregistrerDemande( _desc, _timing, _repmin, _rem, overrides);
            console.log(tx);
            alert("Vous avez bien enregistré votre demande");
            //setTimeout(displayDemands(), 12000);
    
          }catch (err) {
            console.log(tx)
            // Gestion des erreurs
            alert("Ouuups")
            console.error(err);
          
    
    }
    }


    async function promouvoir(indexDemande) {
        try{
            await (dapp.marketPlace.promouvoir(indexDemande));
            alert("Utilisateur promu admin")
            displayDemands()
            }catch (err) {
                // Gestion des erreurs
                alert("Opération abandonnée")
                console.error(err);
        
        }
    }

    async function expulser(indexDemande) {
        try{
            await (dapp.marketPlace.expulser(indexDemande));
            alert("Utilisateur expulsé")
            displayDemands()
            }catch (err) {
                // Gestion des erreurs
                alert("Opération abandonnée")
                console.error(err);
        
        }    
    }