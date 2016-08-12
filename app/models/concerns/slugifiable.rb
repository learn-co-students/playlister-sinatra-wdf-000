module Slugifiable
  module ClassMethods
    def find_by_slug(slug)
      # this needs to be made to work with all
        # songs, artists, genres
      # currently coded to work with spec input
      escape_words = ["with", "a", "the"]
      # r = slug.gsub(/[-]/, ' ').split(" ").map {|w| w.capitalize}.join(" ")
      r = slug.gsub(/[-]/, ' ').split(" ")
      r.map! do |w|
        if !escape_words.include?(w)
          w.capitalize
        else
          w
        end
      end
      r = r.join(" ")
      self.all.find_by(name: r)
    end
  end

  module InstanceMethods
    def slug
      # self.name.gsub(/[ ]/, '-').downcase
      self.name.strip.downcase.gsub(/\W+/, '-')
    end
  end
end