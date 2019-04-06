class AddFieldsInProperties < ActiveRecord::Migration
  def change
    remove_column :properties, :bed_property
    remove_column :properties, :bath_property
    remove_column :properties, :is_tv
    remove_column :properties, :is_air
    remove_column :properties, :is_kitchen
    remove_column :properties, :is_heating
    remove_column :properties, :is_internet
    remove_column :properties, :home_type
    remove_column :properties, :property_type
    remove_column :properties, :bed_property

  end
end
