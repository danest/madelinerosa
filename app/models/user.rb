class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  validates :first_name,  presence: true
  validates :last_name,  presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                  uniqueness: { case_sensitive: false }

  #remove password_confirmation
  has_secure_password validations: false
  validates_presence_of :password, on: :create
end
