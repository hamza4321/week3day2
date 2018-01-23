require_relative "gmail_connect"
require_relative "scrap_mairies"

def get_rows_from_items(items)
  items.map { |item| [item[0]] + item[1].values } # je transforme un tableau contenant un hash en un "simple" tableau = plus de clés (juste les valeurs = les colonnes) => 1 ligne d'infos (1 colonne = 1 info, ex.: nom de la ville, email, etc.) = 1 ville ... n lignes = n villes ... c'est une TABLE (= le MÊME nombre de colonnes à CHAQUE ligne) !!!
end

destinataires = ["jean25pierre2@gmail.com","jeanmichelcodeur@gmail.com", "sebdoe75@gmail.com"] 

$base_url = "http://annuaire-des-mairies.com/"

destinataires = get_emails_from_all_towns_in_dpt("val-d-oise.html")
# p destinataires
destinataires = get_rows_from_items(destinataires)
puts
# p destinataires
destinataires = destinataires.map { |row| row[1] }
p destinataires 

send_mails(destinataires)