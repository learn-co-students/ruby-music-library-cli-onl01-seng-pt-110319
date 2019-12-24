require 'pry'

class Song

    attr_accessor :name, :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist=(artist) if artist != nil
        self.genre=(genre) if genre != nil
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
        new_song = self.new(name)
        new_song.save
        new_song
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre
        @genre
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end

    def self.find_by_name(name)
        all.detect {|song| song.name == name}
    end

    def self.find_or_create_by_name(song)
        if found_song = find_by_name(song) 
            found_song
        else
            create(song)
        end
    end

    def self.new_from_filename(filename)
        file_array = filename.split(" - ")
        artist, song, genre = file_array[0], file_array[1], file_array[2].gsub(".mp3", "")        
        genre = Genre.find_or_create_by_name(genre)
        artist = Artist.find_or_create_by_name(artist)
        new_song = self.new(song, artist, genre)
        new_song
    end

    def self.create_from_filename(filename)
        new_song = new_from_filename(filename)
        new_song.save
    end
end