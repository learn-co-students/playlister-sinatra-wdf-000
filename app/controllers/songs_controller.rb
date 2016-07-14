class SongsController < ApplicationController 
  @songs = Song.all
  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end

  get '/songs/new' do
    erb :'songs/new'
  end

  post '/songs' do
    song = Song.create(name: params[:song][:name])
    artist = Artist.find_or_create_by({:name => params[:song][:artist]})
    song.artist = artist
   
    song.genre_ids << params[:song][:genres] 
    song.save
    redirect to "/songs/#{song.slug}"  
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end

  post '/songs/:slug' do
    song = Song.find_by_slug(params[:slug])
    song.update(name: params[:song][:name])
    artist = Artist.find_or_create_by({:name => params[:song][:artist]})
    song.artist = artist 
    params[:song][:genres].each {|genre| song.genres << Genre.find_or_create_by({:name => genre})}
    song.save
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
  end
end
