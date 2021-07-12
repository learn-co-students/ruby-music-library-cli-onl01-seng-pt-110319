require 'pry'
require "./lib/concerns/findable.rb"

class Genre

    extend Concerns::Findable

    attr_accessor :name

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
        new_genre = self.new(name)
        new_genre.save
        new_genre
    end

    def songs
        @songs
    end

    def artists
       genre_artists = self.songs.map {|song| song.artist}
       genre_artists.uniq
    end

end