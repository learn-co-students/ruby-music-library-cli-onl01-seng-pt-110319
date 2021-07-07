class Song
  extend Concerns::Findable
  attr_accessor :name, :genre
  attr_reader :artist
    @@all = []
  

  def initialize(name, artist=nil, genre= nil)
    @name = name
    self.artist = artist if artist          #invokes #artist= instead of @artist instance variable
    self.genre = genre if genre
    save
  end
  
  def save
    @@all << self
  end
  
  def self.all
    @@all
        #binding.pry
  end
  
  def self.destroy_all
    self.all.clear
  end
  
  def self.create(name)
    Song.new(name)
  end
  
  def artist=(artist)                       # setter method
    @artist = artist
    artist.add_song(self)
  end
  
  def genre= (genre)
    @genre = genre
    unless genre.songs.include?(self)
        genre.songs << self
    end
  end
  
  def self.new_from_filename(filename)
    @name = filename.split(" - ")
    #binding.pry
    song = self.create(@name[1].strip)
    song.artist = (Artist.find_or_create_by_name(@name[0].strip))
    g = @name[2].split(".mp3")
    g = g[0].strip
    song.genre = Genre.find_or_create_by_name(g)
    song
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename)
  end
  
  
  
  
  
end