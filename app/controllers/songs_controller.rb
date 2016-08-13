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

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/edit'
  end

  post '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    # update artist if not empty
    if params[:song][:artist] != ""
      Artist.find(@song.artist_id).update(name: params[:song][:artist])
    end
    # update genres unless empty
    unless params[:song][:genre_ids].empty?
      @song.genres.clear
      params[:song][:genre_ids].each do |id|
        genre = Genre.find(id)
        @song.genres << genre
      end
    end
    @song.save
    session[:success] = "Successfully updated song."
    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    @success = session[:success]
    # binding.pry
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  helpers do
    def find_artist
      Artist.all.detect {|a| a.name.downcase == params[:artist][:name].downcase }
    end
  end


end