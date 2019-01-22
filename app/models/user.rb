class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  # enum, constants
  enum role: {user: 0, admin: 1}

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

  # Create Stripe customer id when create new account
  def assign_customer_id
    customer_list = Stripe::Customer.list email: email
    customer = customer_list.data.first
    customer ||= Stripe::Customer.create email: email
    update_columns customer_id: customer.id
  end

  # Return if user has reviewed a tour
  def reviewed? tour
    review ||= Review.find_by tour_id: tour.id, user_id: id
    reviews.include? review
  end

  private
  # Converts email to all lower-case.
  def downcase_email
    email.downcase!
  end
end
