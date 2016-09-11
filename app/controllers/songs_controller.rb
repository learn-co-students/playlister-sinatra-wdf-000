class SongsController < ApplicationController

  get '/songs' do
    @song = Song.all
    erb :'songs/index'
  end

  get '/songs/new' do

    erb :'songs/new'
  end

  

  get '/songs/:slug' do #bacially means pass in anyhting
    @song = Song.find_by_slug(params[:slug])

    erb :'songs/show'
  end





end
