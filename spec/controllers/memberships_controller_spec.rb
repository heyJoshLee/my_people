require "spec_helper"

describe MembershipsController do
  describe "POST create" do
    context "creates membership" do
      let(:alice) { Fabricate(:user) }
      let(:group) { Fabricate(:group) }

      before do
        sign_in(alice)
        post :create, group_id: group.slug, membership: Fabricate.attributes_for(:membership, group_id: group.id, user_id: alice.id), format: :js
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

  describe "DELETE destroy" do
    let(:group) { Fabricate(:group) }
    let(:alice) { Fabricate(:user) }
    let(:membership) { Fabricate(:membership, group_id: group.id, user_id: alice.id)}

    it "deletes the membership" do
      delete :destroy, group_id: group.id, id: membership.id, format: :js
      expect(Membership.count).to eq(0)
    end
  end
  
end