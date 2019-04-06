class AddRulesInProperties < ActiveRecord::Migration
  def change
    add_column :properties, :rules, :string
  end
end
