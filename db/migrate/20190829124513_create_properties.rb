class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :home_type
      t.string :property_type
      t.integer :accommodate
      t.integer :bed_property
      t.integer :bath_property
      t.string :listing_name
      t.text :summary
      t.string :address
      t.boolean :is_tv
      t.boolean :is_kitchen
      t.boolean :is_air
      t.boolean :is_heating
      t.boolean :is_internet
      t.integer :price
      t.boolean :active
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
