class Category < ActiveRecord::Base
  include Sluggable
  sluggable_column :name

  validates :name, presence: true, length: { minimum: 4, maximum: 30 }
  validates_uniqueness_of :name, case_sensitive: false


end