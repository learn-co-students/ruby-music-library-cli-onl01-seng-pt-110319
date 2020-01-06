class Song
  attr_accessor :name, :artist, :genre

  @@all = []
  extend Concerns::Findable

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.genre = genre
    self.artist = artist
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def self.create(name)
    Song.new(name).tap do |song|
      song.save
    end
  end

  def self.new_from_filename(filename)
    info = filename.split(' - ')
    song_by_name = Song.find_or_create_by_name(info[1])
    artist_by_name = Artist.find_or_create_by_name(info[0])
    genre_by_name = Genre.find_or_create_by_name(info[2].slice(0...-4))
    song_by_name.name = info[1]
    song_by_name.artist = artist_by_name
    song_by_name.genre = genre_by_name
    song_by_name
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
  end

  def save
    @@all << self
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self) if artist != nil
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self if genre != nil && !(genre.songs.include?(self))
  end
end
