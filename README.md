🎯 OBJECTIF
Ce TP consiste à explorer un jeu de données réel (tips) avec les bibliothèques Python Pandas, Matplotlib, Seaborn et NumPy. Le but est de comprendre les comportements de pourboire selon différents facteurs comme le jour, le sexe, le tabagisme ou encore la taille du groupe.

Chargement des données
On utilise la fonction sns.load_dataset("tips") fournie par seaborn pour charger directement le jeu de données.
import seaborn as sns
import pandas as pd

tips = sns.load_dataset("tips")



1. Aperçu du jeu de données
    
- tips.head() affiche les 5 premières lignes.
- tips.columns liste les noms des colonnes.
- tips.dtypes permet de voir le type de chaque colonne (float64, int64, object, etc.).
Cela permet de comprendre la structure et les types de données manipulées.

2. Statistiques descriptives
   
Calculer les statistiques essentielles des colonnes totla_bill, tip, et size. On utilise tips[["total_bill", "tip", "size"]].describe() pour obtenir :
- Moyenne (mean)
- Écart-type (std)
- Min/Max
- Quartiles (25%, 50%, 75%)
Cela donne une idée de la répartition générale de ces valeurs.

3. Valeurs manquantes
   
Avec tips.isna().sum(), on voit s’il manque des valeurs par colonne. Ici, aucune valeur manquante.
C’est important avant de faire des analyses pour éviter des erreurs.

4. Histogrammes
   
Deux histogrammes sont tracés pour visualiser les distributions de total_bill et tip, en 20 classes :
plt.figure(figsize=(10, 5))
plt.hist(tips['total_bill'], bins=20, color='blue')
plt.title('Histogramme de Total Bill')
plt.xlabel('Total Bill')
plt.ylabel('Fréquence')

plt.show()


plt.figure(figsize=(10, 5))
plt.hist(tips['tip'], bins=20, color='green')
plt.title('Histogramme de Tip')
plt.xlabel('Tip')
plt.ylabel('Fréquence')

plt.show()
Ces graphiques montrent comment les valeurs sont réparties dans chaque variable

5. Moyennes groupées
   
Avec groupby, on calcule la moyenne du pourboire selon :
- sex (hommes/femmes)
- smoker (fumeurs ou non)
- day (jour de la semaine)
Cela permet de voir les habitudes de poubloires selon différents les groupes.

6. Pourboire moyen par size
   
On groupe par size (taille de la table) pour voir si les grands groupes donnent plus :
tips.groupby("size")["tip"].mean()



7. Table croisée
Une pivot table affiche la moyenne des pourboires selon les day et time :
pd.pivot_table(tips, index="day", columns="time", values="tip", aggfunc="mean")

Utile pour comparer par exemple le dimanche midi vs soir.

8. Proportion de fumeurs
(tips["smoker"] == "Yes").mean() * 100


Cela donne le pourcentage de fumeurs. Tu peux aussi comparer par sexe.

9. Boxplot des pourboires
Avec sns.boxplot(x="day", y="tip"), on visualise la variabilité des pourboires par jour.
On peut facilement voir quel jour a le plus d'écarts (outliers, médiane, etc.).

10. Nuage de points
sns.scatterplot(x="total_bill", y="tip")


On observe une relation positive : plus la facture est élevée, plus le pourboire tend à augmenter.

14. Pourcentage de pourboire
Nouvelle colonne tip_pct :
tips["tip_pct"] = tips["tip"] / tips["total_bill"]


Puis moyenne et écart-type avec .mean() et .std().

15. Qui donne le plus en proportion ?
On compare tip_pct selon :
- sex
- smoker
- day
Cela révèle des différences culturelles ou sociales dans le comportement des clients.

16. Conversion NumPy
tips[["total_bill", "tip"]].to_numpy()


Cela donne un tableau à 2 colonnes. .shape renvoie les dimensions (n, 2).

17. Calculs vectorisés avec NumPy
Exemples :
- Moyenne : np.mean(tips["tip"])
- Max : np.max(tips["tip"])
- Somme conditionnelle : tips[tips["total_bill"] > 30]["tip"].sum()

18. Filtrage NumPy (avec condition)
tips[tips["size"] >= 4]["tip"]


Cela sélectionne les pourboires quand size >= 4.

19. Indexation booléenne avec Pandas
tips[tips["tip_pct"] > 0.2]


Cela retourne les cas où le pourboire est supérieur à 20% de la note.

20. Fonctions personnalisées .apply()
Tu crées une fonction :
def tip_level(tip):
    if tip < 2:
        return "faible"
    elif tip < 5:
        return "moyen"
    else:
        return "élevé"


Puis :
tips["tip_level"] = tips["tip"].apply(tip_level)


Et on peut voir la répartition avec .value_counts().

21. np.where pour créer une colonne
tips["is_large_party"] = np.where(tips["size"] >= 4, True, False)



22. Tri des factures
np.sort(tips["total_bill"])[-10:]


Affiche les 10 plus grosses additions.

23. Écart-type par jour
tips.groupby("day")["tip_pct"].std()


On voit quel jour le pourboire est le plus variable.

24. Masque NumPy avancé
mask = (tips["tip"] > 5) & (tips["time"] == "Dinner") & (tips["smoker"] == "Yes")
tips[mask]


Cela filtre les cas répondant aux 3 conditions.

25. Jointure avec concaténation
On sépare :
male_df = tips[tips["sex"] == "Male"]
female_df = tips[tips["sex"] == "Female"]

Puis :
pd.concat([male_df, female_df])

Cette commande filtre les données par sexe en deux sous-ensembles (hommes et femmes), puis les concatène verticalement pour reconstituer l’ensemble initial.




