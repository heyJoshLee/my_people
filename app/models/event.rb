class Event < ActiveRecord::Base
  belongs_to :creator, foreign_key: "user_id", class_name: "User"

  validates :name, presence: true, length: {minimum: 3, maximum: 100}
  validates :street_address, presence: true
  validates :zip_code, presence: true, length: {minimum: 5, maximum: 10}
  validates :description, presence: true
  validates :date_time, presence: true

  has_many :rsvps, -> {order("created_at DESC")}
  has_many :comments, -> {order("created_at DESC")}, as: :commentable

  before_create :generate_random_slug

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
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

  def description_truncated(max=140)
    description[0..max]
  end

end