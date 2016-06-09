class User < ActiveRecord::Base
  has_secure_password validations: false

  validates :name, presence: true

  validates :email, presence: true
  validates_uniqueness_of :email, case_sensitve: false

  validates :password, presence: true, length: {minimum: 5, maximum: 20}

  has_many :memberships
  has_many :groups, through: :memberships

  has_many :rsvps

  before_create :generate_random_slug

  has_many :comments, -> {order("created_at DESC")}, as: :commentable



  def is_member_of?(group)
    groups.where(id: group.id).length > 0 ? true : false
  end

  def is_going_to?(event)
    rsvp = rsvps.where(event_id: event.id).first
    rsvp && rsvp.going
  end

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

  def to_param
    self.slug
  end

  # returns events that the user is going to in the future
  def upcoming_rsvps
    events = []
    rsvps.each do |r|
      event = Event.find(r.event_id)
      events << event if event.date_time > DateTime.now.beginning_of_day
    end
    events.sort { |a,b| a.date_time <=> b.date_time }
    events.length > 0 ? events : false
  end


end