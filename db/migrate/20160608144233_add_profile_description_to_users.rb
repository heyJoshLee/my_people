class AddProfileDescriptionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_description, :text
  end
end
