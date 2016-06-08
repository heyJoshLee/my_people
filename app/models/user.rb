class User < ActiveRecord::Base
  has_secure_password validations: false

  validates :name, presence: true

  validates :email, presence: true
  validates_uniqueness_of :email, case_sensitve: false

  validates :password, presence: true, length: {minimum: 5, maximum: 20}

  has_many :memberships
  has_many :groups, through: :memberships

  has_many :rsvps

  def is_member_of?(group)
    groups.where(id: group.id).length > 0 ? true : false
  end

  def is_going_to?(event)
    rsvp = rsvps.where(event_id: event.id).first
    rsvp && rsvp.going
  end

end