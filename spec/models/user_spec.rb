require "shoulda/matchers"
require "rails_helper"

describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  let(:user){FactoryBot.create :user}

  describe "role's enumerations" do
    it "should be either user or admin" do
      is_expected.to define_enum_for(:role).with_values [:user, :admin]
    end
  end

  describe "associations" do
    it "has many bookings" do
      is_expected.to have_many(:bookings).dependent :destroy
    end

    it "has many likes" do
      is_expected.to have_many(:likes).dependent :destroy
    end
    it "has many rates" do
      is_expected.to have_many(:rates).dependent :destroy
    end

    it "has many reviews" do
      is_expected.to have_many(:reviews).dependent :destroy
    end
  end

  context "when validates" do
    describe "name" do
      it {is_expected.to validate_presence_of :name}
      it {is_expected.to validate_length_of(:name).is_at_most 250}
    end

    describe "email" do
      it {is_expected.to validate_presence_of :email}
      it {is_expected.to validate_length_of(:email).is_at_most 250}
      it {is_expected.to validate_uniqueness_of(:email).case_insensitive}
      it "should be invalid format" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
          foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
          user.email = invalid_address
          expect(user).not_to be_valid
        end
      end
      it "should be valid format" do
        addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
        addresses.each do |valid_address|
          user.email = valid_address
          expect(user).to be_valid
        end
      end
    end

    describe "password" do
      it {is_expected.to validate_presence_of :password}
      it {is_expected.to validate_length_of(:password).is_at_least 8}
    end

    describe "phone" do
      it {is_expected.to validate_presence_of :phone}
      it {is_expected.to validate_numericality_of :phone}
      it {is_expected.to validate_length_of(:phone).is_at_least 10}
      it {is_expected.to validate_length_of(:phone).is_at_most 15}
    end
  end

  context "when created" do
    it "should be user by default" do
      user.run_callbacks :create
      expect(user.role).to eq "user"
    end

    it "should downcase email" do
      user.run_callbacks :create
      expect(user.email).to eq user.email.downcase
    end

    it "should be assigned customer id" do
      user.customer_id = nil
      user.run_callbacks :commit
      expect(user.customer_id).not_to be_nil
    end
  end
end
