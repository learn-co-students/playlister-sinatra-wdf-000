require 'rack-flash'
require 'pry'


class SongsController < ApplicationController

  get '/songs' do
    @song = Song.all
    erb :'songs/index'
  end

  enable :sessions
  use Rack::Flash


  get '/songs/new' do

    erb :'songs/new'
  end


  post '/songs' do
    @song = Song.new(name: params[:song_name])
    artist = Artist.find_or_create_by(name: params[:artist_name])
    @song.artist = artist
    genre = Genre.find_by(id: params[:genres])
    @song.genres << genre
    @song.save
    flash[:message] = "Successfully created song."
    redirect to("/songs/#{@song.slug}")
  end







  get '/songs/:slug' do
  @song = Song.find_by_slug(params[:slug])

    erb :'songs/show'
  end




  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
  end
  #
  #
  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    artist = Artist.find_or_create_by(name: params[:artist_name])
    @song.artist.update(name: artist.name)
    genre = Genre.find_or_create_by(id: params[:genres])
    @songs.genres.clear
    @song.genres << genre
    @song.save
    flash[:message] = "Successfully updated song."
    redirect to "/songs/#{@song.slug}"

  end





end
