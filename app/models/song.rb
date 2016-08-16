class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres, through: :song_genres

  attr_accessor :artist_id, :genre_ids
end
