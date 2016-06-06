class Membership < ActiveRecord::Base
  validates_uniqueness_of :user_id, scope: :group_id
  belongs_to :user
  belongs_to :group
end