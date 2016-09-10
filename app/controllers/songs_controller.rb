require 'rack-flash'

class SongsController < ApplicationController

  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    erb :'/songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    # binding.pry
    # binding.pry
    # binding.pry
    # artist = Artist.find_by(id: @song.artist_id)
    # @song.artist = artist
    # song_genre = SongGenre.find_by(song_id: @song.id)
    # genre = Genre.find_by(id: song_genre.genre_id)
    # @song.genre = genre
    erb :'/songs/show'
  end

  post '/songs' do
    @song = Song.create(name: params[:name])
    artist = Artist.find_or_create_by(name: params[:artist_name])
    @song.artist = artist
    genre = Genre.find_by(id: params[:genres])
    @song.genres << genre
    @song.save
    flash[:message] = "Successfully created song."
    redirect to("/songs/#{@song.slug}")
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    # binding.pry
    erb :'/songs/edit'
  end

  patch '/songs/:slug' do
    # binding.pry
    @song = Song.find_by_slug(params[:slug])
    # binding.pry
    @song.update(params[:song])
    artist = Artist.find_or_create_by(name: params[:artist])
    @song.artist = artist
    genre = Genre.find_by(id: params[:genres])
    bruh = []
    bruh << genre
    @song.genres = bruh
    @song.save
    flash[:message] = "Successfully updated song."
    redirect("/songs/#{@song.slug}")
  end

end
