require 'rack-flash'

class SongsController < ApplicationController

  use Rack::Flash
  use Rack::MethodOverride

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    erb :'/songs/new'
  end

  post '/songs' do
    song = Song.create(:name => params[:name])
    artist = Artist.find_or_create_by(:name => params[:artist][:name])
    song.artist = artist
    if !params[:song_genre_ids].nil?
      params[:song_genre_ids].each do |id|
        genre = Genre.find(id)
        GenresSong.create(:genre_id => genre.id, :song_id => song.id)
      end
    end
    if params[:genre][:name] != ""
      genre = Genre.create(:name => params[:genre][:name])
      GenresSong.create(:genre_id => genre.id, :song_id => song.id)
    end
    if song.save
      flash[:message] = "Successfully created song."
      redirect "/songs/#{song.slug}"
    else
      puts "Something went foul. Debug here."
      binding.pry
    end
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/edit'
  end

  patch '/songs/:id/edit' do
    song = Song.find(params[:id])
    if (song.name != params[:name])
      song = Song.update(params[:id], :name => params[:name])
    end
    artist = Artist.find(song.artist_id)
    if artist.name != params[:artist][:name]
      artist = Artist.find_or_create_by(:name => params[:artist][:name])
      song.artist = artist
      song.save
    end
    #find old associations
    old_associations = GenresSong.where(:song_id => song.id).each_with_object(Hash.new) do |assoc, assoc_hash|
      assoc_hash[assoc.id] = assoc.genre_id
    end
    new_associations = params[:song_genre_ids]
    if !params[:song_genre_ids].nil?
        params[:song_genre_ids].each do |id|
        genre = Genre.find(id)
        song.genres_songs.build(genre: genre) if !old_associations.values.include?(genre.id)
      end
    end
    if params[:genre][:name] != ""
      genre = Genre.find_or_create_by(:name => params[:genre][:name])
      song.genres_songs.build(genre: genre) if !old_associations.values.include?(genre.id)
      new_associations << genre.id
    end
    song.save
    #How to remove old, obsolete associations????
    old_associations.each do |assoc_id, assoc_genre_id|
      GenresSong.update(assoc_id, :song_id => :nil, :genre_id => :nil) if !new_associations.include?(assoc_genre_id.to_s)
    end
    if song.save
      flash[:message] = "Successfully updated song."
      redirect "/songs/#{song.slug}"
    else
      puts "Something went foul. Debug here."
      binding.pry
    end
  end

end
