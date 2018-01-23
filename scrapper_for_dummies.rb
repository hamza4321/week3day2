require 'nokogiri'
require 'open-uri'

def scrapper_for_dummies(url, path)
  page = Nokogiri::HTML(open(url))
  return page.css(path)
end
