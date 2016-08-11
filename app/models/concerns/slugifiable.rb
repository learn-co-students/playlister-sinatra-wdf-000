module Slugifiable

  module InstanceMethods
    def slug
      self.name.gsub(" ", "-").downcase
    end
  end
  
  module ClassMethods
    def find_by_slug(slug_name)
      all.find {|name| name.slug == slug_name }
    end
  end

end