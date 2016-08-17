module Slugifiable

  module InstanceMethods

    def slug
      self.name.split(/\s+/).collect{|name_part| name_part.gsub(/\W/,"")}.join("-").downcase
    end

  end

  module ClassMethods

    def find_by_slug(slugified_name)
      self.all.detect {|item| item.slug == slugified_name }
    end
  end


end
