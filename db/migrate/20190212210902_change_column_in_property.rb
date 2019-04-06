class ChangeColumnInProperty < ActiveRecord::Migration
  def change
    remove_column :properties, :min_time
    add_column :properties, :min_time, :integer
  end
end
