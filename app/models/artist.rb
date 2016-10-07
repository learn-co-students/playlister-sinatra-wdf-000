class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def slug
    self.name.downcase.gsub(/\s|\W/, '-')
  end

  # def self.find_by_slug(slug)
  #   name = slug.gsub('-', " ").split(" ").collect {|x| x.capitalize}.join(" ")
  #   found = self.find_by(name: name)
  #   found
  # end

  def self.find_by_slug(slug)
    name1 = slug.gsub('-', " ").split(" ").collect {|x| x.downcase}.join(" ")
    Artist.all.find { |artist| artist.name.downcase == name1 }
  end  

end