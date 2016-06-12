class MakeCategoriesPolymorphic < ActiveRecord::Migration
  def change
    add_column :categories, :categorizable_type, :string
    add_column :categories, :categorizable_id, :integer
  end
end
