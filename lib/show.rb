class Show
    @@all = []
    attr_accessor :name, :location, :showtext, :url
    def initialize(name, url)
        @name = name.strip
        @url = url.strip
     end
    def self.all
        @@all
     end
    def save
        self.class.all << self
     end
    end