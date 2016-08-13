module Slugifiable
  module ClassMethods
    def find_by_slug(slug)
      self.all.detect {|song| song.slug == slug}
    end
  end

  module InstanceMethods
    def slug
      # got regex from: http://slugify.net/libraries
      self.name.strip.downcase.gsub(/\W+/, '-')
    end
  end
end