class Genre < ActiveRecord::Base
  include Slugify::InstanceMethods
  extend Slugify::ClassMethods

  has_many :artists, through: :songs

  # Same principle as in Song model
  has_many :songs, through: :song_genres
  has_many :song_genres
end
