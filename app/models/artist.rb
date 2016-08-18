class Artist < ActiveRecord::Base
  include Slugify::InstanceMethods
  extend Slugify::ClassMethods

  has_many :songs
  has_many :genres, through: :songs

  # def slug
  #   slug = self.name.downcase.split(" ").join("-")
  # end
  #
  # def self.find_by_slug(slug)
  #   name = slug.split("-").collect(&:capitalize).join(" ")
  #   artist = Artist.find_by(name: name)
  # end
end
