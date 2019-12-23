class Artist
    extend Concerns::Findable
    attr_accessor :name
    attr_reader :songs

    @@all = []

    def initialize(name)
        @name = name 
        @songs = []
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
        self.new(name).tap { |artist| artist.save }
        # created_artist = self.new(name)
        # created_artist.save 
        # created_artist
    end

    def add_song(song)
        song.artist = self unless song.artist
        self.songs << song unless self.songs.include?(song)
    end

    def genres
        songs.map { |song| song.genre }.uniq
    end
end