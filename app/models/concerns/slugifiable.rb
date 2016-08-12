module Slugifiable
  module ClassMethods
    def find_by_slug(slug)
      r = slug.gsub(/[-]/, ' ').split(" ").map {|w| w.capitalize}.join(" ")
      self.all.find_by(name: r)
    end
  end

  module InstanceMethods
    def slug
      self.name.gsub(/[ ]/, '-').downcase
    end
  end
end