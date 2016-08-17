module Slugify

  module InstanceMethods
    def slug
      slug = self.name.split(" ").join("-")
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      name = slug.split("-").collect do |word|
        word
      end.join(" ")

      instance = self.find_by(name: name)
    end
  end

end
