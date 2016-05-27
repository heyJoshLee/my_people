require "spec_helper"  


describe SessionsController do


  describe "POST create" do
    context "with valid credentials" do

      let(:alice) { alice = Fabricate(:user) }

      before do
        post :create, email: alice.email, password: alice.password
      end

      it "redirects to the root path" do
        expect(response).to redirect_to root_path
      end

      it "sets the session with the correct user" do
        expect(session[:user_id]).to eq(alice.id)
      end

      it "sets the flash message" do
        expect(flash[:success]).to be_present
      end

    end

    context "with invalid credentials" do

      before do
        post :create, email: "alice@example.com"
      end

      it "sets the flash message" do
        expect(flash[:danger]).to be_present
      end

      it "renders the :new template" do
        expect(response).to render_template :new
      end
      
      it "doesn't set the session" do
        expect(session[:user_id]).to be_nil
      end
    end
  end
  
end