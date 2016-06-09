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
      it "creates an announcement if the user is an admin of the group"
      it "associates the group with the announcement"
      it "doesn't create the announcement if the user cannot modify the group"
    end

    context "with invalid inputs" do

    end

  end
  
end