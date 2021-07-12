require 'pry'
require "./lib/concerns/findable.rb"

class Artist

    extend Concerns::Findable
    
    attr_accessor :name, :song

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
        @@all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all
        all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
        new_artist = self.new(name)
        new_artist.save
        new_artist
    end

    def songs
        @songs
    end

    def add_song(song_inst)
        if song_inst.artist == nil 
            song_inst.artist = self
        end
        if !@songs.include?(song_inst)
        @songs << song_inst
        end
    end

    def genres
        #binding.pry
        genres = self.songs.map {|song| song.genre}
        genres.uniq
    end

end