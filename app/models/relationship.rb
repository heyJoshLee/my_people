class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :leader, class_name: "User"

  before_create :generate_random_number

  def to_param
    self.slug
  end

  def generate_random_number
    self.slug = "_" + SecureRandom.hex(10)
  end

end