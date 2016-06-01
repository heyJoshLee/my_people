class AddLocationToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :city, :string
    add_column :groups, :state, :string
    add_column :groups, :country, :string
  end
end
