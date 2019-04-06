class AddFencedAndBuildingsInProperties < ActiveRecord::Migration
  def change
        add_column :properties, :fenced, :boolean
        add_column :properties, :buildings, :boolean
  end
end
