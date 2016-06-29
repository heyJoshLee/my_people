class AddMapImageUrlToEvents < ActiveRecord::Migration
  def change
    add_column :events, :map_image_url, :string
  end
end
