require 'open-uri'
require 'nokogiri'
require 'pry'
require_relative "./scraper.rb"


class Athlete
  attr_accessor :name, :country, :overall_rank, :country_rank 
  
  @@all = []
  
  
  def initialize(array)
    @name = array[:name]
    @overall_rank = array[:overall_rank]
    @country = array[:country]
    @country_rank = array[:country_rank]
    @@all << self 
  end
  
  
  
  def self.create_from_list(array)
  count = 0
  array.each do |ath|
  athlete = self.new(array[count])
  count +=1
  end 
  
  end 
  
  
  def self.all 
    @@all 
  end 
  
end


Athlete.create_from_list(Scraper.scrape_event_page("5000m","women"))

list = Athlete.all 

count = 1
list.each do |a|

  puts "#{count}." + "#{a.name}" unless a.country_rank > 3
  count += 1 unless a.country_rank > 3
end




















