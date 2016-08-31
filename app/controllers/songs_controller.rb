require 'pry'
require 'rack-flash'

class SongsController < ApplicationController

  get '/songs' do 
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    erb :'/songs/new'
  end

  post '/songs' do 
    # binding.pry
    @song = Song.create(name: params["Name"])
    if !params["Artist Name"].empty?
      @song.artist = Artist.find_or_create_by(name: params["Artist Name"])
    end
    params[:genres].each do |genre|
      @song.genres << Genre.find(genre)
    end
    @song.save
    flash[:message] = "Successfully created song."
    redirect to :"/songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end


  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/edit'
  end

  post '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    if !params["Artist Name"].empty?
      @song.artist = Artist.find_or_create_by(name: params["Artist Name"])
    end
    # @song.genres = []
    @song.genres << Genre.find(params[:song][:genres])
     @song.save
     flash[:message] = "Successfully updated song."
     redirect to :"songs/#{@song.slug}"
  end

end