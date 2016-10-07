class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  def slug
    self.name.downcase.gsub(/\s|\W/, '-')
  end

  def self.find_by_slug(slug)
    name1 = slug.gsub('-', " ").split(" ").collect {|x| x.downcase}.join(" ")
    Song.all.find { |song| song.name.downcase == name1 }
  end
  # def self.find_by_slug(slug)
  #   name = slug.gsub('-', " ").split(" ").collect {|x| x.downcase}.join(" ")
  #   found = Song.all.find_by(name: name)
  #   found
  # end

end