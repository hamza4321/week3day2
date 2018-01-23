require_relative "scrap"
require_relative "save_in"

# $debug = false
$debug = true

$conf = {
  clean: true,
  headers: true
}

def get_rows_from_items(items)
  items.map { |item| [item[0]] + item[1].values } # je transforme un tableau contenant un hash en un "simple" tableau = plus de clés (juste les valeurs = les colonnes) => 1 ligne d'infos (1 colonne = 1 info, ex.: nom de la ville, email, etc.) = 1 ville ... n lignes = n villes ... c'est une TABLE (= le MÊME nombre de colonnes à CHAQUE ligne) !!!
end

base_url = "http://annuaire-des-mairies.com/"
rel_path = "val-d-oise.html"
items  = scrap(base_url, rel_path) # réutilisation du projet précédent pour récupérer les éléments (= 'items') à enregistrer

filepath = "scrapped.json"
# p save_in_json(rows, filepath) # sauvegarde les données au format JSON
# Avantage du JSON sur le CSV
p save_in_json(items, filepath) # vu que JSON n'a pas les mêmes contraintes, on peut stocker de la donnée hiérarchisée (organisée autrement qu'uniquement en lignes de même taille)

rows = get_rows_from_items(items)

filepath = "scrapped.csv"
p save_in_csv(rows, filepath) # sauvegarde les données au format CSV (le 'p' dump la variable)

# Utilisation de Google Spreadsheet pour la sauvegarde
spreadsheet_id = "1AyNWeAb9gdA_njJsCKRrGpDqND4EtiFxuG9w1ngW1ew" # à remplacer par votre id
save_in_google_spreadsheet(spreadsheet_id, items)
