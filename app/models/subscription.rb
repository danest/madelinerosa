class Subscription < ActiveRecord::Base
  belongs_to :user, inverse_of: :subscriptions
  #validates :user_id, :presence => true
  validates :user, :presence => true
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :address_line_one, :presence => true
  validates :zipcode, :presence => true
  validates :plan, :presence => true
end
