# Bullet Train

---

## Codelab

Le jeu complet se trouve sur la branche `main`.

```sh
$ git checkout main
`````````
### Étape 1 - Mise en place du background

Posons les bases dans cette partie en mettant en place la grille de jeu.

Pour démarrer cette étape, passez sur la branche `step1-background`. 

```sh
$ git checkout step1-background
```
### Étape 2 - Mise en place du train

Poursuivons en faisant circuler un train sur cette grille.

Pour démarrer cette étape, passez sur la branche `step2-train`. 

```sh
$ git checkout step2-train
```
### Étape 3 - Contrôles clavier

Le train a besoin de pouvoir tourner pour évoluer. Dans cette partie nous implémentons les contrôles clavier. 

Pour démarrer cette étape, passez sur la branche `step3-keyboard`. 

```sh
$ git checkout step3-keyboard
```
### Étape 4 - Mise en place des voyageurs

Le train a besoin de passagers pour pouvoir grandir (ou rétrécir !). Faisons apparaître des voyageurs sur la grille.

Pour démarrer cette étape, passez sur la branche `step4-travelers`. 

```sh
$ git checkout step4-travelers
```
### Étape 5 - Game Over

Le train ne peut pas encore dérailler mais ça ne saurait tarder. Préparons un Game Over au joueur.

Pour démarrer cette étape, passez sur la branche `step5-gameover`. 

```sh
$ git checkout step5-gameover
```
### Étape 6 - Collisions

L'amour du risque : le train doit désormais pouvoir rentrer en contact avec les murs et les voyageurs.  

Pour démarrer cette étape, passez sur la branche `step6-collisions`. 

```sh
$ git checkout step6-collisions
```
### Étape 7 - Sprites statiques

Personnalisons les voyageurs avec des sprites.

Pour démarrer cette étape, passez sur la branche `step7-staticsprites`. 

```sh
$ git checkout step7-staticsprites
```
### Étape 8 - Sprites animées

Le train mérite lui aussi un ravalement de façade. Cette étape introduit les sprites animées.

Pour démarrer cette étape, passez sur la branche `step8-animatedsprites`. 

```sh
$ git checkout step8-animatedsprites
```
### Étape 9 - Score

Le joueur doit pouvoir consulter son score. Implémentons un Observer pattern à la Flutter. 

Pour démarrer cette étape, passez sur la branche `step9-score`. 

```sh
$ git checkout step9-score
```

---

Lancer l'application sur navigateur
```sh
$ fvm flutter run -d chrome -t lib/main.dart 
```

_\*Bullet Train works on Web, iOS, Android, MacOS and Windows._
