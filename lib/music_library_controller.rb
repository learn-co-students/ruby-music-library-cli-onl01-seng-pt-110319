require 'pry'

class MusicLibraryController

    extend Concerns::Findable
    

    def initialize(path = "./db/mp3s")
     importer_object = MusicImporter.new(path)
     importer_object.import
     
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

            input = gets.chomp

        case input
        when "list songs"
            self.list_songs
        when "list artists"
            self.list_artists
        when "list genres"
            self.list_genres
        when "list artist"
            self.list_songs_by_artist
        when "list genre"
            self.list_songs_by_genre
        when "play song"
            self.play_song
        when "exit"
            'exit'
        else
            call
        end
    end

    def list_songs
        Song.all.sort { |a,b| a.name <=> b.name}.each_with_index.uniq  do |song, index|
            puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    def list_artists
        Artist.all.sort { |a,b| a.name <=> b.name}.select.with_index  do |artist, index|
             puts "#{index + 1}. #{artist.name}"
        end
    end

    def list_genres
         Genre.all.sort { |a,b| a.name <=> b.name}.select.with_index  do |genre, index|
            puts "#{index + 1}. #{genre.name}"
         end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        name = gets.chomp
        artist = Artist.find_by_name(name)
         if artist
            Artist.find_by_name(name)
              artist.songs.sort{ |a,b| a.name <=> b.name}.each.with_index(1)  do |song, index| 
            puts "#{index}. #{song.name} - #{song.genre.name}"
           end
        end
             
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        name = gets.chomp
        genre = Genre.find_by_name(name)
         if genre
            Genre.find_by_name(name)
              genre.songs.sort{ |a,b| a.name <=> b.name}.each.with_index(1)  do |song, index| 
            puts "#{index}. #{song.artist.name} - #{song.name}"
           end
        end
        
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.chomp.to_i
       if (1..Song.all.length).include?(input)
            puts "Playing Larry Csonka by Action Bronson"
        end
    
    end
end


