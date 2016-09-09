class GenresController < ApplicationController

  get '/genres' do
    @genres = Genre.all
    erb :'../views/genres/index'
  end

  get '/genres/new' do 
  end

  get '/genres/:slug' do
    @genre = Genre.all.find { |x| x.name.casecmp(params[:slug].gsub("-", " ")) == 0 }
    erb :'../views/genres/show'
  end

end