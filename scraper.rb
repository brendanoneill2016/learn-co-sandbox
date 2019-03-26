require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper
  
  def self.scrape_event_page(event,gender)
  doc = Nokogiri::HTML(open("https://www.iaaf.org/world-rankings/#{event}/#{gender}?regionType=world&page=1"))
  ranking = doc.css(".table-row--hover")
  array = [] 
  h = {} 
  page_count = (doc.css(".toplist-pagination").css("a").count) - 2
   

  ranking.each do |ath|
    details = ath.css("td")
    
    if h.has_key? :"#{details[3].text.strip}"
    h[:"#{details[3].text.strip}"] = h[:"#{details[3].text.strip}"] + 1
    else 
    h[:"#{details[3].text.strip}"] = 1
    end 
    
    a = {name: details[1].text.strip, overall_rank: details[0].text.strip, country: details[3].text.strip,  country_rank: h[:"#{details[3].text.strip}"] }
    
    array << a 
  end 
  
  p_count = 2 
  
  while p_count <= page_count do
  
  doc = Nokogiri::HTML(open("https://www.iaaf.org/world-rankings/#{event}/#{gender}?regionType=world&page=#{p_count.to_s}"))
   ranking = doc.css(".table-row--hover")
   
   ranking.each do |ath|
    details = ath.css("td")
    
    if h.has_key? :"#{details[3].text.strip}"
    h[:"#{details[3].text.strip}"] = h[:"#{details[3].text.strip}"] + 1
    else 
    h[:"#{details[3].text.strip}"] = 1
    end 
    
    a = {name: details[1].text.strip, overall_rank: details[0].text.strip, country: details[3].text.strip,  country_rank: h[:"#{details[3].text.strip}"] }
    
    array << a 
    
  end 
  
  p_count += 1

end 

array.each do |at|
  puts "#{at[:overall_rank]}: #{at[:name]}" 
end

end


end 


Scraper.scrape_event_page("5000m","women")
