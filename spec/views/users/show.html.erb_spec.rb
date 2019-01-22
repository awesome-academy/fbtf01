require "rails_helper"

describe "users/show.html.erb", type: :view do
  let(:user) {create :user}
  subject{rendered}

  before do
    assign :user, user
    render
  end

  it "should have correct title" do
    expect(subject).to have_content "#{user.name}'s profile"
  end

  it "should have at least 4 fields" do
    expect(subject).to have_css "input", minimum: 4
  end

  describe "input" do
    context "with name" do
      it "should have correct value" do
        expect(subject).to have_css "input#user_name[value=\"#{user.name}\"]"
      end
    end

    context "with email" do
      it "should have correct value" do
        expect(subject).to have_css "input#user_email[value=\"#{user.email}\"]"
      end
    end

    context "with address" do
      it "should have correct value" do
        expect(subject).to have_css "input#user_address[value=\"#{user.address}\"]"
      end
    end

    context "with phone" do
      it "should have correct value" do
        expect(subject).to have_css "input#user_phone[value=\"#{user.phone}\"]"
      end
    end
  end
end
