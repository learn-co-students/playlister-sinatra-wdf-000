require 'pry'
module Slugifiable

  module InstanceMethods
    def slug
      self.name.to_s.gsub(' ','-').downcase
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      # binding.pry
      all.find do |song|
        song.slug == slug
      end
    end
  end

end