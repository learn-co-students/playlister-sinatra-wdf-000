module Slugifiable
  module ClassMethods
    def self.find_by_slug slug
      name = slug.split("-").map{|x| x.capitalize}.join(" ")     
      self.find_by(name: name)
    end
  end

  module InstanceMethods
    def slugify
      self.name.split(/\s+/).map{|x| x.downcase}.join("-")
    end
  end
end
