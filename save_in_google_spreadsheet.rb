require "google_drive"
require_relative "log"

def save_in_google_spreadsheet(spreadsheet_id, items)
  puts if $debug
  debug "Saving data with Google Spreadsheet"

  col_names = ["Ville"] # j'initialise un tableau pour stocker le nom des colonnes (que j'ajouterai -ou pas, en fonction de la conf- en première ligne)
  col_names.concat items.first[1].keys.map { |column| column.to_s } # je récupère les noms de colonnes à partir des symbols utilisés comme clé du hash stockant les inforamtions utiles)
  # p col_names # juste pour montrer à mes guys (étape par étape) ce que contient chaque variable

  session = GoogleDrive::Session.from_config("config.json") # j'initialise ma session en m'authentifiant si besoin (cf. adresse générée par la gem sur la console / le terminal si besoin)
  # p session # peu importe ce qui s'affiche ... c'est juste pour checker que la session est bien initialisée = qu'il s'est passé quelque chose

  worksheet = session.spreadsheet_by_key(spreadsheet_id).worksheets.first # spreadsheet_by_key() permet de récupérer le classeur avec lequel on va bosser ... et worksheets.first la première feuille de calcul (quel que soit son nom)

  if $conf[:clean] # si ce paramètre est mis à 'true' dans app.rb = j'efface tout ce qu'il y a dans le fichier
    debug "Cleaning (all) #{worksheet.num_cols} rows (with #{worksheet.num_rows} columns)" # j'informe l'utilisateur qu'il se passe quelque chose
    worksheet.delete_rows(1, worksheet.num_rows) # j'efface effectivement les lignes ... une lecture de la doc (hein ... les gars ;) permet de faire ça super rapidement
  end

  if $conf[:headers] # si ce paramètre est mis à 'true' dans app.rb = je rajouter une ligne d'entête avec le nom des colonnes
    worksheet.insert_rows(1, [col_names]) # +1 pour la lecture de la doc plutôt que de partir réinventer la roue ... pour rappel : un développeur heureux est un développeur fainéant !!!
  end

  items.each_with_index do |item, row_index|
    debug "item : #{item}" # juste pour voir ce que je reçois effectivement avant de l'insérer dans la feuille de calcul
    row = [item[0]] + item[1].values # je fais le nécessaire pour transformer un tableau du type: [nom_de_ville, {clé_demandée: valeur_trouvée}] en [nom_de_ville, valeur_trouvée]
    row_index = $conf[:headers] ? row_index + 2 : row_index + 1 # s'il y un header (= titre de colonne) décaller les lignes de 2 au lieu de 1 (1 = à cause des index ruby qui commencent à 0 contrairement aux lignes de Google qui commencent à 1) 
    debug "row[#{row_index}] : #{row}" # j'affiche le résultat de cette transformation pour que mes gars puissent à nouveau visualiser les différentes étapes
    worksheet.insert_rows(row_index, [row]) # j'insère la ligne après la dernière contenant quelque chose ... cf. la doc: http://www.rubydoc.info/gems/google_drive/GoogleDrive%2FWorksheet:insert_rows
  end

  worksheet.save # je sauvegarde toutes les modifications apportées au document

end
