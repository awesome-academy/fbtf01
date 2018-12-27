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

  private
  # Converts email to all lower-case.
  def downcase_email
    email.downcase!
  end
end
