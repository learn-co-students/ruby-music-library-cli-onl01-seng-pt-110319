require 'pry'



class Artist
    attr_accessor :name, :songs
     #attr_reader :songs
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def self.all
         @@all
    end

    def self.create(name)
        new_artist = new(name)
        new_artist.save
        new_artist
    end

    def save
        @@all << self
    end

    def self.destroy_all
       self.all.clear 
    end

    def add_song(song)
        song.artist = self unless song.artist
        @songs << song unless @songs.include?(song)  
    end

    def genres
        self.songs.map  { |song|song.genre}.uniq
    

    end


end