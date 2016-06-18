class Group < ActiveRecord::Base
  include Sluggable

  sluggable_column :name

  validates :name, presence: true, length: { minimum: 4, maximum: 50}
  validates_uniqueness_of :name, case_sensitve: false
  validates :description, presence: true, length: { maximum: 2000}

  validates :creator_id, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :category_id, presence: true


  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :category

  has_many :comments, -> {order("created_at DESC")}, as: :commentable
  has_many :announcements, -> {order("position ASC")}, as: :announceable
  
  has_many :memberships
  has_many :users, through: :memberships
  has_many :events, -> {order("date_time ASC")}

  belongs_to :category

  mount_uploader :cover_img, CoverImgUploader
  
  def members
    users.order("created_at DESC")
  end

  def description_truncated(max=140)
    description.length < max ? description : description[0..max] + "..."
  end


  def set_announcements_positions
    ActiveRecord::Base.transaction do
      announcements.each_with_index do |announcement, index|
        announcement.update_attributes!(position: index + 1)
      end
    end
  end

  def has_announcements?
    !announcements.empty?
  end

  def upcoming_events
   events.where(["date_time > ?", DateTime.now.beginning_of_day])
  end
    
end