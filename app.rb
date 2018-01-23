require_relative "scrap"
require_relative "save_in"

# $debug = false
$debug = true

$conf = {
  clean: true,
  headers: true
}

def get_rows_from_items(items)
  items.map { |item| [item[0]] + item[1].values }
end

base_url = "http://annuaire-des-mairies.com/"
rel_path = "val-d-oise.html"
items  = scrap(base_url, rel_path) 

filepath = "scrapped.json"

p save_in_json(items, filepath) 

rows = get_rows_from_items(items)

filepath = "scrapped.csv"
p save_in_csv(rows, filepath) 


spreadsheet_id = "1AyNWeAb9gdA_njJsCKRrGpDqND4EtiFxuG9w1ngW1ew" 
save_in_google_spreadsheet(spreadsheet_id, items)
