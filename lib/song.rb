class Song 

    attr_accessor :name
    attr_reader :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end

    def self.all
        @@all
    end

    def self.destroy_all
        self.all.clear
    end

    def save 
        self.class.all << self
    end

    def self.create(name)
        new(name).tap { |song| song.save }
        # song = new(name)
        # self.all << song
        # song
    end

    def self.find_by_name(name)
        self.all.detect { |song| song.name == name }
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
    end

    def self.new_from_filename(file) 
        artist, song, genre = file.gsub(".mp3", "").split(" - ")
        song_artist = Artist.find_or_create_by_name(artist)
        song_genre = Genre.find_or_create_by_name(genre)
        new_song = new(song, song_artist, song_genre)
    end

    def self.create_from_filename(file)
        self.new_from_filename(file).save
    end
end