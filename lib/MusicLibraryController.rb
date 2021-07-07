class MusicLibraryController
  
  def initialize(path = "./db/mp3s")
    @path = path
    MusicImporter.new(path).import
  end
  
  def call
    puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      command = nil
      while command != "exit" do
        command = gets.chomp
        case command
          when 'list songs'
            list_songs
          when 'list artists'
             list_artists
          when 'list genres'
             list_genres
          when 'list artist'
             list_songs_by_artist   
          when 'list genre'
             list_songs_by_genre
          when 'play song'
             play_song
        end
      end
  end
  
  def list_songs
    Song.all.sort{|a, b|a.name <=> b.name}.each.with_index(1) do |s, i|
     puts "#{i}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
    end
  end
  
  def list_artists
    art = Artist.all.sort_by!{ |a| a.name}
    art.each_with_index {|a, i|puts "#{i+1}. #{a.name}"}
  end
  
  def list_genres
    gen = Genre.all.sort_by!{ |g| g.name}
    gen.each_with_index {|g, i|puts "#{i+1}. #{g.name}"} 
  end
    
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    art = gets.chomp
    if artist = Artist.find_by_name(art)
      artist.songs.sort{|a, b| a.name <=> b.name}.each.with_index(1) do |s, i|
        puts "#{i}. #{s.name} - #{s.genre.name}"
      end
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    gen = gets.chomp
    if genre = Genre.find_by_name(gen)
      genre.songs.sort{|a, b|a.genre <=> b.genre}.each.with_index(1) do |s, i|
        puts "#{i}. #{s.artist.name} - #{s.name}"
      end
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    pic = gets.chomp.to_i
    if (1..Song.all.length).include?(pic)
      puts "Playing Larry Csonka by Action Bronson"
    end
  end
  
end