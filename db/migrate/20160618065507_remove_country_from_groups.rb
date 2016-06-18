class RemoveCountryFromGroups < ActiveRecord::Migration
  def change
    remove_column :groups, :country
  end
end
