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
  validates :country, presence: true
  validates :category_id, presence: true


  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :category
  has_many :comments, as: :commentable

end