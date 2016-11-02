class Song <ActiveRecord::Base
  include Slugifiable
  extend Findable

  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  # def slug
  #   self.name.strip.downcase.gsub(" ", "-")
  # end
  #
  # def self.find_by_slug(slug)
  #   Song.all.find{|song| song.slug == slug}
  # end
end
