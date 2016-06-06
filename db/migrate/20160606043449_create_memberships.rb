class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :user_id, :group_id
      t.string :role
      t.timestamps
    end
  end
end
