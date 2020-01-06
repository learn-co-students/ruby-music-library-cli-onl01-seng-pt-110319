class Genre
  attr_accessor :name, :songs

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
    Genre.new(name).tap do |genre|
      genre.save
    end
  end

  def save
    @@all << self
  end

  def artists
    @songs.map { |song| song.artist }.uniq
  end


end
