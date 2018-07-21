class CreateAccessories < ActiveRecord::Migration[5.1]
  def change
    create_table :accessories do |t|
      t.string :image, default: 'https://asp24.ru/images/companies/1/toughswitch_poe/pics6_1.jpg'
      t.string :title
      t.text :description
      t.integer :price

      t.timestamps
    end
  end
end
