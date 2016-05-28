class Event < ActiveRecord::Base
  belongs_to :creator, foreign_key: "user_id", class_name: "User"
#  belongs_to :category

  validates :name, presence: true, length: {minimum: 3, maximum: 100}
  validates :street_address, presence: true
  validates :zip_code, presence: true, length: {minimum: 5, maximum: 10}
  validates :description, presence: true
  validates :date_time, presence: true


end