# class Artist < ActiveRecord::Base
#   has_many :songs
#   has_many :genres, :through => :songs
class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, :through => :songs

  def slug
     name.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slg)
     Artist.all.find{|a| a.slug == slg}
  end

end
