class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

  def slug
    self.name.downcase.split(" ").join("-")
    # binding.pry
  end

  def self.find_by_slug(arg)
    self.all.find do |genre|
      if genre.slug == arg
        genre
      end
    end
  end

end
