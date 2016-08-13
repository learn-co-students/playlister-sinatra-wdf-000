class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |col|
      col.string :name
    end
  end
end
