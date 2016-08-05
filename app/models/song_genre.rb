class SongGenre < ActiveRecord::Base
  include Slug::InstanceMethods
  extend Slug::ClassMethods
  
  belongs_to :genre
  belongs_to :song
end
