require "spec_helper"

describe MembershipsController do
  describe "POST create" do
    context "creates membership" do
      let(:alice) { Fabricate(:user) }

      before do
        sign_in(alice)
        post :create, membership: Fabricate.attributes_for(:membership, user_id: alice.id)
      end
      it "creates a membership" do
        expect(Membership.count).to eq(1)
      end
      it "associates current user with the membership" do
        expect(Membership.first.user_id).to eq(alice.id)
      end
      it "associates group with membership"
    end
    context "add a user" do
      it "sets role as 'user'"
    end
    context "add an admin" do
      it "sets role as 'admin'"
    end
  end
  
end