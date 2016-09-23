require 'rack-flash'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions
  use Rack::Flash
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    erb :index
  end

  get '/songs' do

    erb :songs
  end

  get '/songs/new' do

    erb :song_new
  end

   post '/songs' do

    @song = Song.create(params[:song])
    @song.artist = Artist.find_or_create_by(name:params["Artist Name"])
    @song.save
    flash[:message] = "Successfully created song."
    redirect "/songs/#{@song.slug}"
  end


  get '/songs/:slug' do

    @song = Song.find_by_slug(params[:slug])
    erb :song
  end


  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :song_edit
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.update(params[:song])
    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
    @song.save

    flash[:message] = "Successfully updated song."
    redirect("/songs/#{@song.slug}")
  end



  get '/artists' do
    erb :artists
  end

  get '/artists/:slug' do
    @artist = Artist.find_by_slug(params[:slug])
    erb :artist
  end

  get '/genres' do
    erb :genres
  end

  get '/genres/:slug' do

    @genre = Genre.find_by_slug(params[:slug])
    erb :genre
  end




end
