require "rails_helper"

describe UsersController, type: :controller do
  context "when current user is not admin" do
    before {get :index}

    it "should redirect to root" do
      expect(response).to redirect_to root_path
    end

    it "should raise error" do
      expect{raise CanCan::AccessDenied}.to raise_error(
        "You are not authorized to access this page.")
    end
  end

  context "when current user is admin" do
    login_admin
    before {get :index}

    it "should have a current_user" do
      expect(subject.current_user).not_to be_nil
    end

    describe "GET #index" do
      let(:users) {create_list :user, 2}

      it "should assign @users" do
        expect(assigns(:users)).to eq users.unshift(subject.current_user)
      end

      it "should render the :index view" do
        expect(response).to render_template :index
      end

      describe "ransack" do
        let!(:user1) {create(:user,
          {name: "John Doe", email: "user1@gmail.com"})}
        let!(:user2) {create(:user,
          {name: "John Wick", email: "user2@example.com"})}

        it "should find two users" do
          get :index, params: {users: {name_or_email_cont: "John"}}
          expect(assigns(:users)).to eq [user1, user2]
        end

        it "should find exactly one user" do
          get :index, params: {users: {name_or_email_cont: "Wick"}}
          expect(assigns(:users)).to eq [user2]
          end
      end
    end

    describe "GET #show" do
      let!(:user) {create :user}

      before do
        get :show, params: {id: user}
      end

      it "should assign the requested user to @user" do
        expect(assigns(:user)).to eq user
      end

      it "should render the :show view" do
        expect(response).to render_template :show
      end
    end

    describe "DELETE #destroy" do
      let!(:user) {create :user}

      it "should delete the @user" do
        expect{
          delete :destroy, params: {id: user}
        }.to change(User, :count).by -1
      end

      context "when @user is destroyed" do
        before {delete :destroy, params: {id: user}}

        it "should redirect to users#index" do
          expect(response).to redirect_to users_path
        end

        it "should flash success message" do
          redirect_to users_path
          expect(flash[:success]).to eq "Delete user successfully"
        end
      end
    end
  end
end
