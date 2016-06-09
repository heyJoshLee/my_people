class Announcement < ActiveRecord::Base
  belongs_to :announceable, polymorphic: true

  def group
    announceable if announceable.class.to_s == "Group"
  end
end