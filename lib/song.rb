require 'pry'


class Song
    attr_accessor :name 
    attr_reader :artist, :genre

    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist = artist if artist != nil
        @genre = genre if genre
    end

    def self.all
        @@all
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def 

    def genre=(genre)
        binding.pry
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)

    end
    

    def self.create(name)
      new_song = Song.new(name)
        new_song.save
        new_song
    
    end

     def self.destroy_all
        self.all.clear 
     end

     def save
         @@all << self
     end
end