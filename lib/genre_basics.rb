class Genre
  attr_accessor :name
    
    @@all = []
    
  def initialize(name)
    @name = name
    save
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    self.all.clear
  end
  
  def save
    @@all << self
  end
  
  def self.create(name)
    Genre.new(name)
  end
end