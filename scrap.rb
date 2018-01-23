require_relative "scrap_mairies"

$base_url = ""

def scrap(base_url, rel_path)
  $base_url = base_url # pour permettre aux autres fonctions de récupérer cette variable globale ... en attendant que je mette à jour le code du scrappeur pour qu'il utilise une variable locale qui sera passée de fonction en fonction

  return get_emails_from_all_towns_in_dpt("val-d-oise.html") # ça renvoie un tableau (1ère colonne = noms des villes, 2ème colonne = hash avec valeur "intéressantes" => uniquement email dans notre cas mais on aurait pu avoir aussi le tél, le nom du contact, etc.)
end
