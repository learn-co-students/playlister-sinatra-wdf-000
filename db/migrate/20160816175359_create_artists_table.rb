class CreateArtistsTable < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.integer :song_genres
    end
  end
end
