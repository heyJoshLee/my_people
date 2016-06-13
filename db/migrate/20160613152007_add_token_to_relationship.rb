class AddTokenToRelationship < ActiveRecord::Migration
  def change
    add_column :relationships, :slug, :string
  end
end
