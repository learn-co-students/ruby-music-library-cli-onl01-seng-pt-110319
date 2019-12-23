class Song 

    attr_accessor :name
    attr_reader :artist, :genre

    @@all = []

    def initialize(name, artist= nil, genre= nil)
        self.artist = artist if artist
        self.genre = genre if genre
        @name = name
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
        self.new(name).tap { |song| song.save }
        # song = self.new(name)
        # song.save 
        # song
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end


    def self.find_by_name(name)
        self.all.find { |song| song.name == name }
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
    end

    def self.new_from_filename(file)
        artist, song, genre = file.gsub(".mp3", "").split(" - ")
        songArtist = Artist.find_or_create_by_name(artist)
        songGenre = Genre.find_or_create_by_name(genre)
        new_song = Song.new(song, songArtist, songGenre)
    end

    def self.create_from_filename(file)
        self.new_from_filename(file).save
    end 
end