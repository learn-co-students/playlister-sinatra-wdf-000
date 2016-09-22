require 'pry'
class Artist < ActiveRecord::Base
	has_many :songs
	has_many :genres, through: :songs

	def slug 
		self.name.downcase.split(" ").join("-")
	end

	def self.find_by_slug(slug)
		Artist.all.find do |name|
			name.slug == slug 
		end
	end

end