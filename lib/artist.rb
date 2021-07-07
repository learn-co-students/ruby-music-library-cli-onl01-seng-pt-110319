require "concerns/findable"
class Artist
  extend Concerns::Findable
  attr_accessor :name
  
    @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
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
    Artist.new(name)
  end
  
  def songs
    @songs
  end
  
  def add_song(song)
    if song.artist == nil
      song.artist = self
    end
    if !@songs.include?(song)
      @songs << song
    end
  end
  
  def genres
     results = songs.collect do|s|
      s.genre
    end 
    results.uniq
  end
  
end