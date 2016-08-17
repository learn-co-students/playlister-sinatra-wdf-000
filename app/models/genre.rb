class Genre < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
  has_many :genres_songs
  has_many :songs, :through => :genres_songs
  has_many :artists, :through => :songs
end
