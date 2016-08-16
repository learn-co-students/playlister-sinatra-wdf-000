class Song < ActiveRecord::Base
  include Slugify::InstanceMethods
  extend Slugify::ClassMethods

  belongs_to :artist

  # in order to use the through, class has to have
  # many of the connecting table
  has_many :genres, through: :song_genres

  # In this case this is the connecting table
  has_many :song_genres
end
