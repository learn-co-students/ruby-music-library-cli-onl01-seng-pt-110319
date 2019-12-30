require 'pry'
class Artist
  extend Concerns::Findable
  include Concerns::InstanceMethods
  @@all=[]
  attr_accessor :name
  def initialize(name)
    @name=name
    @songs = []
    self.save
  end
  def add_song(song)
      song.artist=self unless song.artist == self
      self.songs << song unless self.songs.include?(song)
  end
  def songs
    @songs
  end
  def genres
    results = self.songs.collect {|song| song.genre}
    results.uniq
  end
  def new_from_filename(filename)
#Artist Name - Song Titile - genre.filetpye
    song_title=filename.split(" - ")[1]
    artist_name=filename.split(" - ")[0]
    genre_name=filename.split(" - ")[2].chomp(".mp3")
    artist=Artist.find_or_create_by_name(artist_name)
    genre=Genre.find_or_create_by_name(genre_type)
    song=Song.find_or_create_by_name(song_title, artist, genre)
    artist
  end
end
