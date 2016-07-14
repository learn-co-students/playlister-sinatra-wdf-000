require 'rack-flash'
class SongsController < ApplicationController 
  enable :sessions 
  use Rack::Flash
 
  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end

  get '/songs/new' do
    erb :'songs/new'
  end

  post '/songs' do
    song = Song.new(name: params[:song][:name])

    artist = Artist.find_or_create_by({:name => params[:song][:artist]})
    song.artist = artist
   
    song.genres << Genre.find(params[:song][:genres]) 
    if song.save
      flash[:message] = "Successfully created song."
      redirect to "/songs/#{song.slug}"  
    end
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end

  post '/songs/:slug' do
    song = Song.find_by_slug(params[:slug])
    song.name =  params[:song][:name]
    if !params[:song][:name].empty?
      artist = Artist.find_or_create_by({:name => params[:song][:artist]})
      song.artist = artist  
    end
    song.genres << Genre.find(params[:song][:genres]) 
    if song.save
      flash[:message] = "Successfully updated song."
      redirect to "/songs/#{song.slug}"
    end
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
  end
end
