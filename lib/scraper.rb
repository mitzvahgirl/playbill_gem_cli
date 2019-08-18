BASE_URL = "https://www.playbill.com/"

class Scraper
  def self.scrape_shows
    doc = Nokogiri::HTML(open("http://www.playbill.com/productions?q=&venue-type=broadway&zip="))
    show_elements = doc.css("div.pb-pl-tile-text-box").each do |div|
      name = div.css('a')[0].text
      url = "http://www.playbill.com" + div.css('a').attr('href').value
      #get bio text from show url
      show_doc = Nokogiri::HTML(open(url))
      showtext = show_doc.css('.bsp-bio-text')[0].text.strip
      show = Show.new(name, url, showtext)
      show.save
    end
  end

def self.scrape_location(show)
    if !show.location
      url = show.url
      html = open(BASE_URL +url)
      doc = Nokogiri::HTML(html)
      if doc.search(".div.pb-pl-tile-location").text != ""
          show.location = doc.search("div.pb-pl-tile-location").text
      end
    end
  end

  def self.scrape_showtext(show)
    if !show.showtext
      url = show.url
      html = open(BASE_URL + url)
      doc = Nokogiri::HTML(html)
      if doc.search("div.pb-pl-tile-title").text != ""
        show.showtext = doc.search("div.pb-pl-tile-title").text 
      else 
        show.showtext = doc.search("div.pb-pl-tile-title").text
      end
    end
  end
end
