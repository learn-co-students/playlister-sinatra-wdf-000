require 'rack-flash'
class SongsController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/songs/") }
  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :index
  end

  get '/songs/new' do
    erb :new
  end
  get '/songs/:slug' do

    @song = Song.find_by_slug(params[:slug])
    @artist = Artist.find(@song.artist_id)

    @genres = @song.genres
    # binding.pry
    erb :show
  end


  post '/songs' do
    if !params[:artist_name].empty?
      artist = Artist.find_or_create_by(name: params[:artist_name])
      params[:song][:artist_id] = artist.id
    end
    song = Song.new(params[:song])

    params[:genres].each do |genre_id|
      song.genres << Genre.find(genre_id)
    end

    if song.save
      flash[:message] = "Successfully created song."
      redirect "/songs/#{song.slug}"
    else
      puts "failure"
    end
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    # binding.pry
    erb :edit
  end

  post '/songs/:slug' do

    song = Song.find_by_slug(params[:slug])

    if !params[:artist_name].empty?
      artist = Artist.find_or_create_by(name: params[:artist_name])
      params[:song][:artist_id] = artist.id
    end

    song.update(params[:song])

    params[:genres].each do |genre_id|
      song.genres << Genre.find(genre_id)
    end

    if song.save
      flash[:message] = "Successfully updated song."
    end
    redirect "/songs/#{song.slug}"
  end
end
