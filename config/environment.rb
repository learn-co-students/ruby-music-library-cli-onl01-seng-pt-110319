require 'bundler'
require 'pry'
Bundler.require
module Concerns
  module Findable
    #class methods
    @@all=[]
    def all
     @@all
    end
    def sorted
      @@all.sort_by do |instance|
        instance.name
      end
    end
    def save
      self.all<<self
    end
    def destroy_all
      self.all.clear
    end
    def create(name)
      self.new(name)
    end
    def find_by_name(name)
      self.all.find do |o|
        o.name==name
      end
    end
    def find_or_create_by_name(name)
      if self.find_by_name(name) == nil
        self.create(name)
      else
        self.find_by_name(name)
      end
    end
    def create_from_filename(filename)
      self.new_from_filename(filename)
      self.save
    end
  end
  module InstanceMethods
    def save
      self.class.all << self
    end
  end
end
require_all 'lib'
