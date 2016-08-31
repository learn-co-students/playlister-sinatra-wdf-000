require 'rack-flash'

class SongsController < ApplicationController
	
	use Rack::Flash

	get '/songs' do 
		@songs = Song.all
		erb :'/songs/index'
	end

	get '/songs/new' do 
	 erb :'/songs/new'
	end

	get '/songs/:slug' do 
		@song = Song.find_by_slug(params[:slug])
		@artist = @song.artist
		@genres = @song.genres
		erb :'/songs/show'
	end

	post '/songs' do
		@song = Song.create(params[:song])
		@artist = Artist.find_or_create_by(params[:artist])
		@song.artist = @artist
		@song.genre_ids = params[:genres]
		# params[:genres].each do |genre_id|
		# 	@song.genres << Genre.all.find{|i| i.id == genre_id.to_i }
		# end

		@song.save

		flash[:message] = "Successfully created song."
		redirect to("/songs/#{@song.slug}")
	end

	get '/songs/:slug/edit' do
		@song = Song.find_by_slug(params[:slug])
		erb :'/songs/edit'
	end

	post '/songs/:slug' do
		@song = Song.find_by_slug(params[:slug])
		@song.update(params[:song])
		@artist = Artist.find_or_create_by(params[:artist])
		@song.artist = @artist
		@song.genre_ids = params[:genres]
		@song.save
		flash[:message] = "Successfully updated song."
		redirect to("/songs/#{@song.slug}")
	end

end