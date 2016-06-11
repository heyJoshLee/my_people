require "spec_helper"


describe AnnouncementsController do
  describe "POST new" do
    context "with valid inputs" do
      let(:group) { Fabricate(:group) }
      let(:announcement_params) { Fabricate.attributes_for(:announcement)}

      it "creates an announcement if the user is an admin" do
        admin = Fabricate(:admin)
        sign_in(admin)
        Membership.create(group_id: group.id, user_id: admin.id, role: "user")
        post :create, group_id: group.slug, announcement: {announceable_id: group.id, body: "Here is some text"}, object_type: "Group", format: :js
        expect(Announcement.count).to eq(1)
      end
      it "creates an announcement if the user is an admin of the group" do
        admin_for_group = Fabricate(:user)
        sign_in(admin_for_group)
        Membership.create(group_id: group.id, user_id: admin_for_group.id, role: "admin")
        post :create, group_id: group.slug, announcement: {announceable_id: group.id, body: "Here is some text"}, object_type: "Group", format: :js
        expect(Announcement.count).to eq(1)
      end

      it "associates the group with the announcement" do
        admin_for_group = Fabricate(:user)
        sign_in(admin_for_group)
        Membership.create(group_id: group.id, user_id: admin_for_group.id, role: "admin")
        post :create, group_id: group.slug, announcement: {announceable_id: group.id, body: "Here is some text"}, object_type: "Group", format: :js
        expect(Announcement.first.group).to eq(group)
      end

      it "doesn't create the announcement if the user is just a 'user' of the group" do
        user = Fabricate(:user)
        sign_in(user)
        Membership.create(group_id: group.id, user_id: user.id, role: "user")
        post :create, group_id: group.slug, announcement: {announceable_id: group.id, body: "Here is some text"}, object_type: "Group", format: :js
        expect(Announcement.count).to eq(0)
      end
    end

    context "with invalid inputs" do
      it "doesn't create the group" do
        group = Fabricate(:group)
        admin_for_group = Fabricate(:user)
        sign_in(admin_for_group)
        Membership.create(group_id: group.id, user_id: admin_for_group.id, role: "admin")
        post :create, group_id: group.slug, announcement: {announceable_id: group.id}, object_type: "Group", format: :js
        expect(Announcement.count).to eq(0)
      end
    end

  end

end