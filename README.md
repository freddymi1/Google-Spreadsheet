> Mini-projet **Google Spreadsheet (Solo)** <br>
Realiser par **NARISOA HARILALA Freddy Michel**

Cette mini-projet consiste a enregistrer au dans un fichier email.JSON les emails
du Val d'Oise. Le programme est ecrit en POO. Pour ce faire, nous prenons notre exercice precedent et le mettre dans une classe.

Elle se divise en 3 parties dont:
## 1. Enregistrer dans un JSON
> Dans cet exercice, nous allons te demander d'enregistrer au dans un fichier ***emails.json*** les emails
du Val d'Oise.

## 2. Google Spreadsheet
> Cette partie consiste sur l'enregistrement des villes et des emails de Val d'Oise sur ***googlesheet***

## 2. Enregistrer dans un CSV
> Dans cet exercice, nous allons te demander d'enregistrer au dans un fichier ***emails.csv*** les emails
du Val d'Oise.
## Structure du dossier
L'organisation du projet est comme le suis


```mermaid
                JSON_scrapper
                    ├── .gitignore
                    ├── README.md
                    ├── Gemfile
                    ├── Gemfile.lock
                    ├── app.rb
                    ├── db
                        └── emails.JSON
                    └── lib
                        └── scrapper.rb
```

> Le class **Scrapper** se trouve dans le fichier ***scrapper.rb*** qui est dans le dossier lib. Dans cette class, on trouve toutes les methodes qui permetent de telecharger les donnees depuis le site du ***Val d'Oise*** et le methode qui permet de les enregistrer dans les fichier JSON, CSV et Google Spreadsheet.

    > **initialize:** c'est le constrictuer dans la class Scrapper
    > **urlp:** Declaration de l'url du site a scrapper
    > **get_townhall_email:** Elle nous permet de scraper les les emails et la ville des mairies
    > **get_townhall_urls:** Elle permet d'aller sur le site pour scraper les informations.
    > **generate_spreadsheet:** Elle nous permet de créer / modifier un fichier dans google sheet.
    > **generateFile:** Elle perment de generer les fichier emails.json et emails.csv dans le dossier lib
> Le dossier **db** contient les fichier ***emails.JSON*** et ***emails.csv*** qui sont des fichier creer automatiquement apres le lancement du programme.

> Le fichier **app.rb** est un fichier qui contient toutes les instanciations de classe dans le fichier **scrapper.rb**

## Fonctionnalite du programme

Pour lancer le programme, ouvrir le terminal dans la dossier JSON_scrapper, ecrir ensuite dans la terminal ***ruby app.rb*** et faire entrer, le fichier ***emails.json*** et ***emails.csv*** se regenerent automatiquemet, et en meme temps, les donnees s'enregistrent dans google sheet 