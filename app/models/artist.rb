class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def slug
    self.name.downcase.split(" ").join("-")
    # binding.pry
  end

  def self.find_by_slug(arg)
    self.all.find do |artist|
      if artist.slug == arg
        artist
      end
    end
  end

end
