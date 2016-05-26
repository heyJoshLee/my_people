class User < ActiveRecord::Base
  has_secure_password validations: false

  validates :name, presence: true

  validates :email, presence: true
  validates_uniqueness_of :email, case_sensitve: false

  validates :password, presence: true, length: {minimum: 5, maximum: 20}

end