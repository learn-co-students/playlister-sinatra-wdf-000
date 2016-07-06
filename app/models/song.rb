class Song < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

  belongs_to :artist
  has_many :genres, through: :songs_genres
end
