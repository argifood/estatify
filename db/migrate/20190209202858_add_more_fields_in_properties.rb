class AddMoreFieldsInProperties < ActiveRecord::Migration
  def change
    add_column :properties, :space_type, :string
    add_column :properties, :category, :string
    add_column :properties, :flatness, :string
    add_column :properties, :dimensions, :float
    add_column :properties, :ground_type, :string
    add_column :properties, :charge_per, :string
    add_column :properties, :min_time, :string
    add_column :properties, :power_supply, :boolean
    add_column :properties, :water_supply, :boolean
    add_column :properties, :animals, :boolean
    add_column :properties, :vehicles, :boolean
    add_column :properties, :drilling, :boolean
    add_column :properties, :water_system, :boolean
    add_column :properties, :tools, :boolean
    add_column :properties, :pools_lakes, :boolean
    add_column :properties, :constructions, :boolean
    add_column :properties, :anti_fire, :boolean
    add_column :properties, :lightning, :boolean
    add_column :properties, :alarm_system, :boolean
    add_column :properties, :cctv, :boolean
    add_column :properties, :solar_panels, :boolean
    add_column :properties, :wind_turbines, :boolean

  end
end
