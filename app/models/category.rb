class Category < ActiveRecord::Base
  include Sluggable
  sluggable_column :name

  validates :name, presence: true, length: { minimum: 4, maximum: 30 }
  validates_uniqueness_of :name, case_sensitive: false

  def groups
    Group.where(category_id: id)
  end

  def events
    Event.where(category_id: id)
  end

  def most_popular_groups
    groups.order("created_at ASC").limit(5)
  end

end