class Announcement < ActiveRecord::Base
  belongs_to :announceable, polymorphic: true

  validates :body, presence: true, length: {maximum: 1000}

  def group
    announceable if announceable.class.to_s == "Group"
  end
end