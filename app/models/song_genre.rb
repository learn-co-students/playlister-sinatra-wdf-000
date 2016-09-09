class SongGenre < ActiveRecord::Base

  belongs_to :song
  belongs_to :genre

  def slug
    self.name.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    name = slug.gsub("-", " ").split(" ").collect {|x| x.capitalize}.join(" ")
    self.find_by(name: name)
  end

end