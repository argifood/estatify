class AddGplusInUsers < ActiveRecord::Migration
  def change
    add_column :users, :gplus_link, :string
  end
end
