class AddTimestampsToRsvps < ActiveRecord::Migration
  def change
    add_column :rsvps, :created_at, :datetime
    add_column :rsvps, :updated_at, :datetime
  end
end
