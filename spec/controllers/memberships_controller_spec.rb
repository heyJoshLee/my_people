require "spec_helper"

describe MembershipsController do
  describe "POST create" do
    context "creates membership" do
      it "creates a membership" do
        post :create, membership: Fabricate.attributes_for(:membership)
        expect(Membership.count).to eq(1)
      end
      it "redirects to the group page"
      it "associates current user with the membership"
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