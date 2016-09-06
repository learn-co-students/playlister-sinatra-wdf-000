class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, :through => :song_genres


  def slug 
      #  name.split(" ").join("-")
     name.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slg)
     Song.all.find{|a| a.slug == slg}
  end

end
