class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.text :body
      t.string :announceable_type
      t.integer :announceable_id
      t.integer :user_id
      t.timestamps
    end
  end
end
