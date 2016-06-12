class AddCoverImageToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :cover_img, :string
  end
end
