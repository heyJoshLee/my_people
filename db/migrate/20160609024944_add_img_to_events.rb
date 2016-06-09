class AddImgToEvents < ActiveRecord::Migration
  def change
    add_column :events, :img, :string
  end
end
