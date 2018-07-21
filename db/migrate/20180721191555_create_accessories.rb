class CreateAccessories < ActiveRecord::Migration[5.1]
  def change
    create_table :accessories do |t|
      t.string :image
      t.string :title
      t.text :description
      t.integer :price

      t.timestamps
    end
  end
end
