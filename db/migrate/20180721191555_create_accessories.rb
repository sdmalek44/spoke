class CreateAccessories < ActiveRecord::Migration[5.1]
  def change
    create_table :accessories do |t|
      t.string :image, default: 'https://www.hsjaa.com/images/joomlart/demo/default.jpg'
      t.string :title
      t.text :description
      t.float :price

      t.timestamps
    end
  end
end
