class SongGenre < ActiveRecord::Base
  belongs_to :genre
  belongs_to :song
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
end
