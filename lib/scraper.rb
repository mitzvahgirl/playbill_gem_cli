 #scraper.rb
    
 require 'pry'
 BASE_URL = "https://www.playbill.com/"
 class Scraper
   def self.scrape_shows
     doc = Nokogiri::HTML(open("http://www.playbill.com/productions?q=&venue-type=broadway&zip="))
     show_elements = doc.css("div.pb-pl-tile-text-box")
     # don't get the showtext here, just get the url and defer the scrape for that text to when the user asks for it.
     show_elements.each do |div|
       name = div.css('a')[0].text
       url = "http://www.playbill.com" + div.css('a').attr('href').value
       show = Show.new(name, url)
       show.save
     end
   end
 # def self.scrape_location(show)
 #     if !show.location
 #       url = show.url
 #       html = open(BASE_URL +url)
 #       doc = Nokogiri::HTML(html)
 #       if doc.search(".div.pb-pl-tile-location").text != ""
 #           show.location = doc.search("div.pb-pl-tile-location").text.strip
 #       end
 #     end
 #   end
   
   def self.scrape_showtext(show)
     # this is where we scrape the showtext if it doesn't already exist
     if !show.showtext
       url = show.url
       html = open(url)
       doc = Nokogiri::HTML(html)
       if doc.css('.bsp-bio-text')
         show.showtext = doc.css('.bsp-bio-text')[0].text.strip
         show.save
       end
     end
   end
 end
 
