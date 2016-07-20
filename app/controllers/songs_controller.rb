class SongsController < ApplicationController

@@notice = ""

  get '/songs' do
    erb :'songs/index'
  end

  get '/songs/new' do
    erb :'songs/new'
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
  end

  patch "/songs/:slug" do
    @song = Song.find_by_slug(params[:slug])
    if !params["artist_name"].empty?
      @song.artist = Artist.find_or_create_by(name: params["artist_name"])
    end
    if !params["genres"].empty?
      new_genres = []
      params["genres"].each {|genre| new_genres << Genre.find_or_create_by(id: genre)}
      @song.genres = new_genres
    end
    @song.save
    @@notice = "Successfully updated song."
    redirect to "songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    flash[:notice] = @@notice
    erb :'songs/show'
  end

  post '/songs' do
    @song = Song.create(name: params["song_name"])
    @song.artist = Artist.find_or_create_by(name: params["artist_name"])
    params["genres"].each {|genre| @song.genres << Genre.find_or_create_by(id: genre)}
    @song.save
    @@notice = "Successfully created song."
    redirect to "songs/#{@song.slug}"
  end

end
