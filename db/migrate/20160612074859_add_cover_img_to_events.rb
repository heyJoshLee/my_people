class AddCoverImgToEvents < ActiveRecord::Migration
  def change
    add_column :events, :cover_img, :string
  end
end
