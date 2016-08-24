class SongsController < ApplicationController
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }


  get '/songs' do
    erb :'songs/index'
  end

  get '/songs/new' do
    erb :"/songs/new"
  end
  get '/songs/:slug' do
    slug = params[:slug]
    @song = Song.find_by_slug(slug)
    erb :"songs/show"
  end

  post '/songs' do
    song_name = params["Name"]
    artist_name = params["Artist Name"]
    @song = Song.create(:name => song_name)
    @artist = Artist.find_or_create_by(:name => artist_name)
    @song.artist = @artist
    @song.genre_ids = params["genre"]
    @song.save
    redirect to("/songs/#{@song.slug}")
  end



  get '/songs/:slug/edit' do
    erb :"songs/edit"
  end

  post '/songs/:slug/edit' do
    redirect :"songs/:slug"
  end

end
