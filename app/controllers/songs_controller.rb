class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    erb :'/songs/new'
  end

  post '/songs' do
    song = Song.create(params[:song])
    if !!find_artist == false
      artist = Artist.create(params[:artist])
      song.artist = artist
    else
      song.artist = find_artist
    end
    song.save
    session[:success] = "Successfully created song."
    redirect "/songs/#{song.slug}"
  end

  get "/songs/:slug" do
    # binding.pry
    @success = session[:success]
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  def find_artist
    Artist.all.detect {|a| a.name.downcase == params[:artist][:name].downcase }
  end

end