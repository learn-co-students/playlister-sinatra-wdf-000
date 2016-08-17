class SongsController < ApplicationController
  get '/songs' do
    @songs = Song.all
    # Make sure the path is defined correctly for each view!
    erb :'/songs/index'
  end
end
