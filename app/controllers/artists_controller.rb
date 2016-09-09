class ArtistsController < ApplicationController

  get '/artists' do
    @artists = Artist.all
    erb :'../views/artists/index'
  end

  get '/artists/new' do 

  end

  get '/artists/:slug' do
    @artist = Artist.all.find { |x| x.name.casecmp(params[:slug].gsub("-", " ")) == 0 }
    erb :'../views/artists/show'
  end

end