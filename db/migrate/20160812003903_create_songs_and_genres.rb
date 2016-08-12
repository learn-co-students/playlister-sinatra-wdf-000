class CreateSongsAndGenres < ActiveRecord::Migration
  def change
    create_table :songs_genres do |col|
      col.integer :song_id
      col.integer :genre_id
    end
  end
end
