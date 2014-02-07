require 'rubygems'
require 'nokogiri'
require 'open-uri'

URL = "http://en.wikipedia.org/wiki/List_of_countries_by_population"
doc = Nokogiri::HTML(open(URL))

countries = doc.css('table.wikitable tr:nth-child(2)~tr td:nth-child(2) a:nth-child(2)')
countries.each {|name| puts name['title']}

populations = doc.css('table.wikitable tr:nth-child(2)~tr td:nth-child(3)') 
populations.each {|num| puts num.text}
