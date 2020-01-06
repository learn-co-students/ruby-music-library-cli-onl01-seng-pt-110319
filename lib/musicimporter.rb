class MusicImporter

  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    data = Dir[@path + "/*"]
    formatted_data = data.collect { |song_info| song_info.slice((@path.length + 1),(song_info.length - 1)) }
  end

  def import
    files.each { |song| Song.create_from_filename(song) }
  end
end
