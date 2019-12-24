require 'pry'
module Concerns::Findable

    def find_by_name(name)
        #iterating using detect which returns the first true value
        #passing in a in our pipes for artist
        #artist.name is equal to name
        self.all.detect { |a| a.name == name}
    end

    def find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
    end


    




end


#   expected #<Artist:70234930110380> => #<Artist:0x00007fc1b01ebf58 @name="Slowdive", @songs=[]>