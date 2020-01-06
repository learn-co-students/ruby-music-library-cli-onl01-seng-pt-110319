class Artist
  attr_accessor :name

  @@all = []
  extend Concerns::Findable

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def self.create(name)
    Artist.new(name).tap do |artist|
      artist.save
    end
  end

  def save
    @@all << self
  end

  def songs
    @songs
  end

  def add_song(song)
    @songs << song unless @songs.include?(song)
    song.artist = self if song.artist == nil
  end

  def genres
    @songs.map { |song| song.genre }.uniq
  end
end
