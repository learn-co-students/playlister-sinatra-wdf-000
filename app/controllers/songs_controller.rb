class SongsController < ApplicationController
  get '/songs' do
    # Make sure the path is defined correctly for each view!
    erb :'/songs/index'
  end
end
