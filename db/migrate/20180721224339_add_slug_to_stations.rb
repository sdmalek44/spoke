class AddSlugToStations < ActiveRecord::Migration[5.1]
  def change
    add_column :stations, :slug, :string
  end
end
