=begin
#---------------------------------------------------------------------

scraper.rb
written by: William Ersing

This code scrapes country specific population data from Wikipedia.
The purpose is to learn about web scraping, specifically with the
Ruby language. Information is stored in a hash, and is displayed to 
the user in HTML (this part is under construction)

#---------------------------------------------------------------------
=end

require 'rubygems'
require 'nokogiri'
require 'open-uri'

URL = "http://en.wikipedia.org/wiki/List_of_countries_by_population"
doc = Nokogiri::HTML(open(URL))

countries = Array.new
populations = Array.new
country_list = {}

doc.css('table.wikitable tr:nth-child(2)~tr').each do |item|
    countries << item.at_css('td:nth-child(2) a:nth-child(2)')['title']
    populations << item.at_css('td:nth-child(3)').text
end

@countries=countries
@populations=populations

(0..@countries.length - 1).each do |index|
    country_list[@countries[index]] = @populations[index]
end

puts "Here is a list of populations by country\n\n"
country_list.each do |key, value|
    puts "#{key}:\t\t#{value}"
end
