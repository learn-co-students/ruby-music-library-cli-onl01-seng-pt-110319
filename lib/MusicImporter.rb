class MusicImporter
  attr_accessor :path, :files, :name
  def initialize(path)
    @path = path
    @files = Dir.entries(path).select{|e|e.include?("-")}
  end
    
  def import
    files.each{|f|f = Song.create_from_filename(f)}
  end
   
end