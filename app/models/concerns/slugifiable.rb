module Slugifiable
  def slug
    name.downcase.gsub(/ /, '-')
  end
  def find_by_slug(slug)
    self.all.detect {|instance| instance.slug == slug}
  end
end
