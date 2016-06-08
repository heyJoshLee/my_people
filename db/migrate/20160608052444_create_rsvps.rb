class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.integer :user_id, :event_id
      t.boolean :going
    end
  end
end
