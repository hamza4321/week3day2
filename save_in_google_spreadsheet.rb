require "google_drive"
require_relative "log"

def save_in_google_spreadsheet(spreadsheet_id, items)
  puts if $debug
  debug "Saving data with Google Spreadsheet"

  col_names = ["Ville"] 
  col_names.concat items.first[1].keys.map { |column| column.to_s } 

  session = GoogleDrive::Session.from_config("config.json") 

  worksheet = session.spreadsheet_by_key(spreadsheet_id).worksheets.first 
  if $conf[:clean] 
    debug "Cleaning (all) #{worksheet.num_cols} rows (with #{worksheet.num_rows} columns)" #
    worksheet.delete_rows(1, worksheet.num_rows) 
  end

  if $conf[:headers] 
    worksheet.insert_rows(1, [col_names]) 
  end

  items.each_with_index do |item, row_index|
    debug "item : #{item}" 
    row = [item[0]] + item[1].values 
    row_index = $conf[:headers] ? row_index + 2 : row_index + 1 
    debug "row[#{row_index}] : #{row}" 
    worksheet.insert_rows(row_index, [row]) 
  end

  worksheet.save

end
