require 'pry'

class MusicImporter
    attr_accessor :path, :files, :song
  
    def initialize(path)
      @path = path
    end
  
    def files
        Dir.glob("#{path}/*.mp3").collect {|f| f.gsub("#{path}/", "") }
        #binding.pry
    end

    def import 
      files.each {|file| Song.create_from_filename(file)}
    end
end