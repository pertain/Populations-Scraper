=begin
----------------------------------------------------------------------------
scraper.rb
written by: William Ersing

This program extracts country-specific population data from wikipedia. The
data is stored in a hash. Users are asked to enter the name of a specific
country, the population of that country is then displayed on the screen. The
user can also opt to see the entire list of countries and populations.
----------------------------------------------------------------------------
=end

require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "http://en.wikipedia.org/wiki/List_of_countries_by_population"
doc = Nokogiri::HTML(open(url))

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

=begin
puts "Here is a list of populations by country\n\n"
country_list.each do |key, value|
    puts "#{key}:\t\t#{value}"
end
=end
#==========================================================================


selection = ''
puts "\n     \\\\\\\\\\\ POPULATIONS /////"
while selection.casecmp('quit') != 0 do
    puts "\n================================="
    puts "~Enter the name of a country\n~Type 'all' to show all countries\n~Type 'quit' to exit" 
    puts "=================================\n"
    selection = gets.chomp
    if selection.casecmp('quit') != 0
	if selection.casecmp('all') == 0
	    longest_key = country_list.keys.max {|key1, key2| key1.length <=> key2.length}
	    puts ''
	    country_list.each do |key, value|
		 printf("%-#{longest_key.length}s %s\n", key, value)
	    end
	else
	    country_list.each do |key, value|
		# working on comparing user input to keys to find a match
		# so far this is fruitless - internet fails me too!
		# HOW TO SEARCH/COMPARE KEY VALUES TO A STRING!?!?
		#----------------------------------------
		if country_list.key?(selection)
		    puts "#{selection}: #{value}"
		    break
		else puts "#{key} is not in the list of countries"
		end
		#puts country_list.keys.to_s
		#puts key.to_s
		#----------------------------------------
=begin
		if selection.casecmp(key.to_s) == 0
		    printf("%-#{key.length}s %s\n", key, value)
		end
=end
	    end
	    #puts "#{selection} is not in the list of countries"
	end
    end
end

