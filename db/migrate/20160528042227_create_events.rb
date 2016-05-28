class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, :street_address, :zip_code
      t.integer :user_id, :category_id
      t.text :description
      t.timestamp :date_time
      t.timestamps
    end
  end
end
