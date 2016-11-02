class Artist < ActiveRecord::Base
  include Slugifiable
  extend Findable

  has_many :songs
  has_many :genres, through: :songs

  # def slug
  #   self.name.strip.downcase.gsub(" ", "-")
  # end
  #
  # def self.find_by_slug(slug)
  #   Artist.all.find{|artist| artist.slug == slug}
  # end
end
