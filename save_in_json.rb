require "json"
require_relative "log"

def save_in_json(rows, filepath = nil) # par défaut ne fait que générer du JSON (= ne l'enregistre pas dans un fichier ... ça peut être utile dans certains cas)
  puts if $debug
  debug "Saving data as JSON"
  json = rows.to_json # grâce à la gem json, on transforme le JSON en UNE SEULE ligne ... pour pouvoir l'enregistrer dans un fichier !
  File.open(filepath, "w") { |f| f.write(json) } unless filepath.nil? # n'enregistre dans un fichier que si le paramètre contenant le nom de fichier est fourni !
  return json
end
