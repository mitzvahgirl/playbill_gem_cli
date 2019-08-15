class Show
    @@all = []

    attr_accessor :name, :location, :showtext

    def initialize(name, url)
        @name = name
        @location = location
        @showtext = showtext
    end

    def self.all
        @@all
    end

    def save
        self.class.all << self
    end
end