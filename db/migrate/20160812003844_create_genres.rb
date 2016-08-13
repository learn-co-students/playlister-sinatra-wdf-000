class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres do |col|
      col.string :name
    end
  end
end
