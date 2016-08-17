class SongsController < ApplicationController
  get '/songs' do
    @songs = Song.all
    # Make sure the path is defined correctly for each view!
    erb :'/songs/index'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @artist = @song.artist
    @genres = @song.genres
    erb :'/songs/show'
  end
end
