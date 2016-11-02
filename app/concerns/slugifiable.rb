module Slugifiable
  def slug
    self.name.strip.downcase.gsub(" ", "-")
  end
end
