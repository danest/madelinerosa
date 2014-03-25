class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token


  validates :first_name,  presence: true
  validates :last_name,  presence: true
  validates :email, presence: true,
                  uniqueness: { case_sensitive: false }

  #remove password_confirmation
  has_secure_password validations: false
  validates_presence_of :password, on: :create

  has_many :subscriptions
  validates_associated :subscriptions


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end
end
