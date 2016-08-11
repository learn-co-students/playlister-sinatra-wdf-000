# require 'pry'
require 'rack-flash'
class SongsController < ApplicationController
  use Rack::Flash
  get '/songs' do 
    erb :'songs/index'
  end

  get '/songs/new' do
    @genre = Genre.all
    erb :'songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end

  post '/songs' do
    artist = Artist.find_or_create_by(name: params[:artist])
    params["artist"] = artist

    genres = []
    params[:genres].each do |id|
      genres << Genre.find(id.to_i)
    end
    params["genres"] = genres
    # binding.pry
    song = Song.new(params)
    song.save

    flash[:message] = "Successfully created song."
    redirect to "/songs/#{song.slug}"
  end

  get '/songs/:slug/edit' do 
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
    # binding.pry
  end

  patch '/songs/:slug' do
    song = Song.find_by_slug(params[:slug])
    song.name = params[:name]
    song.artist = params[:artist]
    genres = []
    params[:genres].each do |id|
      genres << Genre.find(id.to_i)
    end
    song.genre = genres
    flash[:message] = "Successfully updated song."
    redirect to "songs/#{params[:slug]}"
  end

end