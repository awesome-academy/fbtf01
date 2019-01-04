class User < ApplicationRecord
  # enum, constants
  enum role: {user: 0, admin: 1}

  # attr_
  attr_accessor :reset_token

  # relationships
  has_many :bookings, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :reviews, dependent: :destroy

  # validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: {with: VALID_EMAIL_REGEX},
    presence: true,
    uniqueness: {case_sensitive: false},
    length: {maximum: Settings.users.email.max_length}

  has_secure_password
  validates :password, presence: true,
    length: {minimum: Settings.users.password.min_length},
    allow_nil: true

  validates :name, presence: true,
    length: {maximum: Settings.users.name.max_length}

  validates :phone, presence: true,
    length: {
      minimum: Settings.users.phone.min_length,
      maximum: Settings.users.phone.max_length
    }, numericality: true

  # callbacks
  before_save :downcase_email

  after_commit :assign_customer_id, on: :create

  # scopes
  scope :newest, ->{order created_at: :desc}

  class << self
    # Returns the hash digest of the given string.
    def digest string
      cost = BCrypt::Engine::MIN_COST if ActiveModel::SecurePassword.min_cost
      cost = BCrypt::Engine.cost unless ActiveModel::SecurePassword.min_cost
      BCrypt::Password.create string, cost: cost
    end

    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns reset_digest: User.digest(reset_token),
      reset_sent_at: Time.zone.now
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < Settings.users.password.reset_expired.minutes.ago
  end

  # Create Stripe customer id when create new account
  def assign_customer_id
    customer = Stripe::Customer.create email: email
    update_columns customer_id: customer.id
  end

  private
  # Converts email to all lower-case.
  def downcase_email
    email.downcase!
  end
end
