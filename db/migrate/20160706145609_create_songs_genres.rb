class CreateSongsGenres < ActiveRecord::Migration
  def change
    create table :songs_genres do |t|
      t.integer :song_id
      t.integer :genre_id
    end
  end
end
