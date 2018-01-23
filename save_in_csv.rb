require "csv"
require_relative "log"

def save_in_csv(rows, filepath = nil) # par défaut ne fait que générer du CSV (= ne l'enregistre pas dans un fichier ... ça peut être utile dans certains cas)
  puts if $debug
  debug "Saving data as CSV"
  lines = rows.inject([]) { |csv, row|  csv << CSV.generate_line(row) } # pour chaque ligne reçues on genère une nouvelle ligne (ajoutée au tableau csv) au format CSV
  csv = lines.join('') # on transforme le tableau de ligne en UNE SEULE ligne ... pour pouvoir l'enregistrer dans un fichier !
  File.open(filepath, "w") { |f| f.write(csv) } unless filepath.nil? # n'enregistre dans un fichier que si le paramètre contenant le nom de fichier est fourni !
  return csv
end
