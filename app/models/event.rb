class Event < ActiveRecord::Base
  belongs_to :creator, foreign_key: "user_id", class_name: "User"

  validates :name, presence: true, length: {minimum: 3, maximum: 100}
  validates :street_address, presence: true
  validates :zip_code, presence: true, length: {minimum: 5, maximum: 10}
  validates :description, presence: true
  validates :date_time, presence: true

  has_many :rsvps, -> {order("created_at DESC")}
  has_many :comments, -> {order("created_at DESC")}, as: :commentable
  has_many :announcements, -> {order("position ASC")}, as: :announceable

  belongs_to :category
  belongs_to :group

  before_create :generate_random_slug

  mount_uploader :cover_img, CoverImgUploader

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

  def self.upcoming
    where(["date_time > ?", DateTime.now.beginning_of_day]).order("date_time ASC")
  end

  def to_param
    self.slug
  end

  def all_going
    rsvps.where(going: true)
  end

  def all_not_going
    rsvps.where(going: false)
  end

  def formatted_address
    output = street_address.strip.gsub(" ", "-") + "," +
    city.strip.gsub(" ", "-") + "," +
    state.strip.gsub(" ", "-")
    output
  end

  def generate_map_image
    url = "https://maps.googleapis.com/maps/api/staticmap?center="+ 
    formatted_address +
    "&zoom=13&size=600x300&maptype=roadmap&" +
    "markers=color: blue%7Clabel:X%7C" +
    formatted_address +
    "&key=" + ENV['GOOGLE_MAPS_API_KEY']
    assign_attributes({map_image_url: url})
  end

  def description_truncated(max=140)
    description.length < max ? description : description[0..max] + " ..."
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


end