Jeu des Civilisations
=====================



Le but du jeu
-------------
Obtenir le plus de point de gloire pour créer des merveilles dans sa civilisation.



Commencement
------------
Un joueur fonde sa civilisation originelle. Cela lui coûte 0.1 ethers. Cette civilisation est unique (ERC721) et est caractérisée par plusieurs items dont son identité (choisie au hasard). Toute civilisation commence à l'age 1 par une identité aléatoire.



Description d'une civilisation
------------------------------

Le Joueur va ensuite devoir conduire sa civilisation au fil des âges en choisissant certaines divinations, éléments & technologie et en faisant évoluer son royaume dans ces directions d'âge en âge.


Identité
<table>
    <tr>
	<th>Genesis</th>
        <td>Sage</td>
	<td>Agressif</td>
        <td>Reclus</td>
	<td>Imprévisible</td>
    </tr>
</table>

Elements
<table>
    <tr>
	<th>Age 1</th>
        <td>Sol</td>
	<td>Ether</td>
        <td>Feu</td>
	<td>Eau</td>
    </tr>
    <tr>
	<th>Age 2</th>
        <td>Terre</td>
	<td>Ciel</td>
        <td>Foudre</td>
	<td>Glace</td>
    </tr>
        <tr>
	<th>Age 3</th>
        <td>Kernel</td>
	<td>Solaire</td>
        <td>Plasma</td>
	<td>Cristal</td>
    </tr>
</table>

Divination
<table>
    <tr>
	<th>Age 1</th>
        <td>Thor</td>
	<td>Zeus</td>
        <td>Shiva</td>
	<td>Osiris</td>
    </tr>
    <tr>
	<th>Age 2</th>
        <td>Drakkar</td>
	<td>Panthéon</td>
        <td>Tungnath</td>
	<td>Pyramide</td>
    </tr>
    <tr>
	<th>Age 3</th>
        <td>Ragnarok</td>
	<td>Olympus</td>
        <td>Qomolangma </td>
	<td>Ikhernofret</td>
    </tr>
</table>

Technologie
<table>
    <tr>
	<th>Age 1</th>
        <td>Atome</td>
	<td>Photon</td>
        <td>Sombre</td>
	<td>Philosophy</td>
    </tr>
    <tr>
	<th>Age 2</th>
        <td>Electron</td>
	<td>Lumière</td>
        <td>Antiparticule</td>
	<td>Universalité</td>
    </tr>
    <tr>
	<th>Age 3</th>
        <td>Plasma</td>
	<td>Etoile</td>
        <td>Trou Noir</td>
	<td>Omniscience</td>
    </tr>
</table>


Conduite d'une civilisation
------------------------------
Plusieurs actions sont possibles d'entreprendre avec vos civilisations. Chaque joueur joue chacun son tour.

1.  ##La guerre
* #La conquête
>Vous gagnez une bataille contre un autre royaume. Vous gagnez le droit d'évoluer d'un âge.

* #Le pillage
>Vous vous introduisez chez l'adversaire et vous lui pillez une compétence.

* #La capture
>Vous faites abdiquer le roi adverse et récupérez sa couronne et sa civilisation.

2.  ##La paix
* #L'achat
>Vous pouvez acheter le droit de copier une compétence chez une autre civilisation.

* #L'harmonie
>Vous pouvez vous concentrer sur une compétence précise que vous possédez et la faire évoluer vers un autre âge.

* #Muraille
>Vous pouvez faire échouer une action de guerre entreprise contre vous.


Finale
------

Tous les 50 000 blocs, es points de gloire sont calculés pour chaque civilisation selon un algorithme interne qui prend en compte le nombre d'ages atteints, la complétion d'une famille (technologie, élément, divination). A ce résultat sont ajoutés les points de gloire de toute autre civilisation possédée et du nombre de sesterces du joueur en fin de partie.

Le gagnant reçoit alors le droit de créer une merveille du monde dans sa civilisation originelle moyennant 50 000 sesterces.
