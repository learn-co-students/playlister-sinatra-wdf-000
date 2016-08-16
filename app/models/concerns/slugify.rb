module Slugify
  
  module InstanceMethods
    def slug
      slug = self.name.downcase.split(" ").join("-")
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      name = slug.split("-").collect(&:capitalize).join(" ")
      instance = self.find_by(name: name)
    end
  end

end
