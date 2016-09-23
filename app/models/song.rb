class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, :through =>  :song_genres
  def slug
    @input = self.name.downcase.gsub(" ",'-')

  end

  def self.find_by_slug(slug)
    # slug = slug.gsub(/\s|\W/," ")
    # sql = "Select lower(artist.name) from artist where name = ?"
    # @name = ActiveRecord::Base.connection.execute("select * from artists where name LIKE '#{slug}' LIMIT 1")
    Song.all.find do |a|
      slug == a.slug
    end
    # @name = @name[0]["name"].to_s
    # @name

  end
end
