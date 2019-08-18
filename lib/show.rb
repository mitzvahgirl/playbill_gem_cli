class Show
@@all = []

attr_accessor :name, :location, :showtext, :url

def initialize(name, url, showtext)
    @name = name
    # @location = location
    @showtext = showtext
    @url = url
 end

def self.all
    @@all
 end

def save
    self.class.all << self
 end
end