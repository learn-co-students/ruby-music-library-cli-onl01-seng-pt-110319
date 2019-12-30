require 'pry'
class Song
  extend Concerns::Findable
  include Concerns::InstanceMethods
  @@all=[]
  attr_accessor :name
  attr_reader :artist, :genre
  def initialize(name, artist=nil, genre=nil)
    @name=name
    self.artist=(artist) if artist
    self.genre=(genre) if genre
    self.save
  end
  def artist=(artist)
    @artist=artist
    artist.add_song(self) unless artist==nil
  end
  def genre=(genre)
    @genre=genre
    genre.songs << self unless genre == nil || genre.songs.include?(self)
  end
  def self.new_from_filename(filename)
    #Artist Name - Song Titile - genre.filetpye
    song_title=filename.split(" - ")[1]
    artist_name=filename.split(" - ")[0]
    genre_name=filename.split(" - ")[2].chomp(".mp3")
    artist=Artist.find_or_create_by_name(artist_name)
    genre=Genre.find_or_create_by_name(genre_name)
    song=Song.find_or_create_by_name(song_title)
    song.artist=artist
    song.genre=genre
    song
  #  binding.pry
  end
end
