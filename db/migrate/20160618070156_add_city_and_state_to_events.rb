class AddCityAndStateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :city, :string
    add_column :events, :state, :string
  end
end
