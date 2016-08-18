class ArtistsController < ApplicationController
  get '/artists' do
    @artists = Artist.all
    erb :'/artists/index'
  end

  get '/artists/:slug' do
    @artist = Artist.find_by_slug(params[:slug])
    @artist_songs = @artist.songs
    @artist_genres = @artist.songs.collect do |song|
      song.genres
    end.flatten
    erb :'/artists/show'
  end
end
