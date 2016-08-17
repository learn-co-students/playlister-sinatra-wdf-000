module Slugify

  module InstanceMethods
    def slug
      slug = self.name.downcase.split(" ").join("-")
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.detect {|name| name.slug == slug}
    end
  end

end
