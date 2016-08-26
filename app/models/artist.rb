class Artist < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  has_many :genres, through: :songs
  has_many :songs

end