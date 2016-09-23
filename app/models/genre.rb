class Genre < ActiveRecord::Base
  has_many :songs
  has_many :song_genres
  has_many :songs, :through => :song_genres
  has_many :artists, through: :songs
  def slug
    @input = self.name.gsub(/\s|\W/,'-').downcase
  end

  def self.find_by_slug(slug)
    # slug = slug.gsub(/\s|\W/," ")
    # sql = "Select lower(artist.name) from artist where name = ?"
    # @name = ActiveRecord::Base.connection.execute("select * from artists where name LIKE '#{slug}' LIMIT 1")
    Genre.all.find do |a|
      slug == a.slug
    end
    # @name = @name[0]["name"].to_s
    # @name

  end
end
