class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  def slug
    self.name.downcase.split(" ").join("-")
    # binding.pry
  end

  def self.find_by_slug(arg)
    self.all.find do |song|
      if song.slug == arg
        song
      end
    end
  end

end
