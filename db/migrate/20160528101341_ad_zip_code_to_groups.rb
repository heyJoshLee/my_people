class AdZipCodeToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :zip_code, :string
  end
end
