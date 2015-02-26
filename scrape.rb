=begin
================================================================================
scraper.rb
Written by: William Ersing

This program extracts country-specific population data from wikipedia. The data
is strored in a hash. Users are asked to enter the name of a specific country.
The population of that country is then displayed on the screen. The user can
also opt to see the entire list of countries and populations.
================================================================================
=end

require 'rubygems'
require 'nokogiri'
require 'open-uri'

# This method takes a url argument and returns a hash that contains the extracted
# url data. The key/value pairs are countries/populations.
def fill_hash(url)
    @url = url
    countries = Array.new
    populations = Array.new
    country_hash = {}

    doc = Nokogiri::HTML(open(@url))
    doc.css('table.wikitable tr:nth-child(2)~tr').each do |item|
	countries << item.at_css('td:nth-child(2) a:nth-child(2)')['title']
	populations << item.at_css('td:nth-child(3)').text
    end

    @countries = countries
    @populations = populations

    (0..@countries.length - 1).each do |index|
	country_hash[@countries[index]] = @populations[index]
    end
    return country_hash
end

# This method takes a hash argument and provides a user interface that loops
# until the user elects to quit.
def ui(hash)
    selection = ''
    puts "\n~~~~~~~~~~ POPULATIONS ~~~~~~~~~~"

    until selection == 'Quit' do
	puts "\n================================="
	puts "~Enter the name of a country\n~Type 'all' to show all countries\n~Type 'quit' to exit"
	puts "=================================\n"

	selection = gets.chomp.split.map(&:capitalize).join(' ')			# capitalize each word of the input string (this allows user
											# to enter any combination of capital and lowercase letters)
	if selection != 'Quit' 
	    if selection == 'All' 
		longest_key = hash.keys.max {|key1, key2| key1.length <=> key2.length}	# determine the necessary column width
		printf("\n\n%-#{longest_key.length}s %s\n", 'Country', 'Population')
		puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
		hash.each do |key, value|
		printf("%-#{longest_key.length}s %s\n", key, value)			# column alignment formatting
		end
	    else
		if hash.has_key?(selection)
		    puts "\n#{selection} has a total population of #{hash[selection]}"
		else
		    puts "\n#{selection} was not found"
		end
	    end
	end
    end
end

country_list = fill_hash('http://en.wikipedia.org/wiki/List_of_countries_by_population')
ui(country_list)

