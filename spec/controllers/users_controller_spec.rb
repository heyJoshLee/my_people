require "spec_helper"

describe UsersController do

  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST new" do
    context "with valid inputs" do

      let (:user_params) { Fabricate.attributes_for(:user, email: "example@example.com") }
      before do
        post :create, user: user_params
      end

      after do
        ActionMailer::Base.deliveries.clear
      end

      it "renders edit template" do
        expect(response).to render_template :edit
      end

      it "creates user" do
        expect(User.count).to eq(1)
      end

      it "sets flash message" do
        expect(flash[:success]).to be_present
      end

      it "sends a welcome email" do
        expect(ActionMailer::Base.deliveries.last.to).to eq(["example@example.com"])
      end
    end

    context "with invalid inputs" do
      before do
        post :create, user: { email: "example@example.com"}
      end

      it "does not create the user" do
        expect(User.count).to eq(0)
      end

      it "sets flash message" do
        expect(flash[:danger]).to be_present
      end

      it "renders the :new template" do
        expect(response).to render_template :new
      end

      it "does not send a welcome email" do
        expect(ActionMailer::Base.deliveries).to be_empty
      end

    end
  end


end