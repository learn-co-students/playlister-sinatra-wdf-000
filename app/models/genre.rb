class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

  def slug
    self.name.downcase.gsub(/\s|\W/, '-')
  end

  # def self.find_by_slug(slug)
  #   name = slug.gsub('-', " ").split(" ").collect {|x| x.capitalize}.join(" ")
  #   self.find_by(name: name)
  # end

  def self.find_by_slug(slug)
    name1 = slug.gsub('-', " ").split(" ").collect {|x| x.downcase}.join(" ")
    Genre.all.find { |genre| genre.name.downcase == name1 }
  end

end