class Artist < ActiveRecord::Base
  has_many :songs
  has_many :song_genres, through: :song_genres

  attr_accessor :song_genres, :genres

  def genres
    self.songs.all.collect { |song| song.genre_ids }
  end

  def slug
    slug = self.name.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    name = slug.split("-").collect(&:capitalize).join(" ")
    artist = Artist.find_by(name: name)
  end
end
