require 'pry'
class Genre
    extend Concerns::Findable

    attr_accessor :name, :songs

    @@all = []

    def initialize(name)
        @name = name
        # @@all << self
        @songs = []
        
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        self.class.all << self
    end

    def self.create(name)
        song = new(name)
        song.save
        song
    end

    def artists
        songs.collect { |s| s.artist}.uniq
        
    end

   




end