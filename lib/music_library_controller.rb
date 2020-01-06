class MusicLibraryController
  attr_accessor :path

  def initialize(path = './db/mp3s')
    importer = MusicImporter.new(path)
    importer.import
  end

  def get_input_from_user
    gets.chomp.strip
  end

  def song_list
    Song.all.uniq.sort_by { |song| song.name }
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
    input = get_input_from_user
    case input
    when "list songs"
      list_songs
    when "list artists"
      list_artists
    when "list genres"
      list_genres
    when "list artist"
      list_songs_by_artist
    when "list genre"
      list_songs_by_genre
    when "play song"
      play_song
    end
    call if input != "exit"
  end

  def list_songs
    song_list = Song.all.uniq.sort_by { |song| song.name }
    song_list = song_list.map { |song| "#{song.artist.name} - #{song.name} - #{song.genre.name}" }
    song_list.each_with_index { |song, i| puts "#{i + 1}. " + song}
  end

  def list_artists
    artist_list = Artist.all.uniq.sort_by { |artist| artist.name }
    artist_list = artist_list.map { |artist| "#{artist.name}" }
    artist_list.each_with_index { |artist, i| puts "#{i + 1}. " + artist }
  end

  def list_genres
    genre_list = Genre.all.uniq.sort_by { |genre| genre.name }
    genre_list = genre_list.map { |genre| "#{genre.name}" }
    genre_list.each_with_index { |genre, i| puts "#{i + 1}. " + genre}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = get_input_from_user
    if Artist.find_by_name(input)
      song_list = Artist.find_by_name(input).songs.uniq.sort_by { |song| song.name }
      song_list.each_with_index { |song, i| puts "#{i + 1}. #{song.name} - #{song.genre.name}"}
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = get_input_from_user
    if Genre.find_by_name(input)
      songs_sorted_by_genre = Genre.find_by_name(input).songs.uniq.sort_by { |song| song.name }
      songs_sorted_by_genre.each_with_index { |song, i| puts "#{i + 1}. #{song.artist.name} - #{song.name}"}
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = get_input_from_user.to_i - 1
    if song_list[input] && (0...song_list.length - 1).include?(input)
      puts "Playing #{song_list[input].name} by #{song_list[input].artist.name}"
    end
  end



end
