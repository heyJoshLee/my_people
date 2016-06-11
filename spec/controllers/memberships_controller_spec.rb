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
      it "associates group with membership" do
        expect(Membership.first.group_id).to eq(group.id)
      end
    end

    context "add a user" do
      let(:alice) { Fabricate(:user) }
      let(:group) { Fabricate(:group) }

      it "sets role as 'user'" do 
        sign_in(alice)
        post :create, group_id: group.slug, membership: Fabricate.attributes_for(:membership, group_id: group.id, user_id: alice.id), format: :js
        expect(Membership.first.role).to eq("user")
      end
    end

    context "add an admin to the group" do
      let(:group) { Fabricate(:group) }
      let(:regular_user) { Fabricate(:user) }

      it "adds an admin to the group if the current user is an admin of the site" do
        admin = Fabricate(:admin)
        sign_in(admin)
        post :create, group_id: group.slug, role: "admin", membership: Fabricate.attributes_for(:membership, group_id: group.id, user_id: regular_user.id), format: :js
        expect(Membership.last.role).to eq("admin")
      end

      it "adds an admin to the group if the current user is an admin of the group" do
        admin_of_group = Fabricate(:user)
        Membership.create(user_id: admin_of_group.id, group_id: group.id, role: "admin")
        sign_in(admin_of_group)
        post :create, group_id: group.slug, role: "admin", membership: Fabricate.attributes_for(:membership, group_id: group.id, user_id: regular_user.id), format: :js
        expect(Membership.last.role).to eq("admin")
      end

      it "sets new membership role as user if current_user doesn't have permission to add admins" do
        user = Fabricate(:user)
        sign_in(user)
        post :create, group_id: group.slug, role: "admin", membership: Fabricate.attributes_for(:membership, group_id: group.id, user_id: regular_user.id), format: :js
        expect(Membership.last.role).to eq("user")
      end
    end
  end

  describe "DELETE destroy" do
    let(:group) { Fabricate(:group) }
    let(:alice) { Fabricate(:user) }
    let(:membership) { Fabricate(:membership, group_id: group.id, user_id: alice.id)}

    it "deletes the membership" do
      sign_in
      delete :destroy, group_id: group.id, id: membership.id, format: :js
      expect(Membership.count).to eq(0)
    end
  end
  
end