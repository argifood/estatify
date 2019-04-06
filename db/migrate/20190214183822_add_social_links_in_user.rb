class AddSocialLinksInUser < ActiveRecord::Migration
  def change
    add_column :users, :fb_link, :string
    add_column :users, :twitter_link, :string
    add_column :users, :lkdin_link, :string
    add_column :users, :skype_link, :string
  end
end
