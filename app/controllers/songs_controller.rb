require 'pry'
class SongsController < ApplicationController
  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    # Make sure the path is defined correctly for each view!
    erb :'/songs/index'
  end

  # Only responsibility is to render the new song form
  get '/songs/new' do
    erb :'/songs/new'
  end

  post '/songs' do
    @artist = Artist.find_or_create_by(params[:artist])
    @genre = Genre.find_or_create_by(params[:genre])
    @song = Song.create(params[:song])

    # Associate song with artist and genre(s)
    @song.artist = @artist
    @song.song_genres.build(genre: @genre)
    @song.save

    # Set flash entry
    flash[:notice] = "Successfully created song."
    redirect to "/songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @artist = @song.artist
    @genres = @song.genres
    erb :'/songs/show'
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/edit'
  end

  post '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
    @song.update(params[:song])
    @song.save

    flash[:notice] = "Successfully updated song."
    redirect to "/songs/#{@song.slug}"
  end

end
