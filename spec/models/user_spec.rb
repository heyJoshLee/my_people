require "spec_helper"

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:email)}
  it { should have_secure_password }

  describe "#can_modify_group?(group)" do
    let(:group) { Fabricate(:group) }

    it "returns true if user is admin" do
      admin = Fabricate(:admin)
      expect(admin.can_modify_group?(group)).to be_truthy
    end
    it "returns true if user is admin of the group" do
      admin_for_group = Fabricate(:user)
      Membership.create(group_id: group.id, user_id: admin_for_group.id, role: "admin")
      expect(admin_for_group.can_modify_group?(group)).to be_truthy
    end
    it "returns false if the user is not an admin or admin for the group" do
      user = Fabricate(:user)
      expect(user.can_modify_group?(group)).to be_falsey
    end
  end

  describe "#is_member_of?(group)" do
    let(:alice) { Fabricate(:user) }
    let(:group) {Fabricate(:group) }

    it "returns false if the user isn't in the group" do
      expect(alice.is_member_of?(group)).to be_falsy
    end

    it "returns true if the user is in the group" do
      membership = Fabricate(:membership, user_id: alice.id, group_id: group.id)
      expect(alice.is_member_of?(group)).to be_truthy
    end

  end

  describe "#is_going_to?(event)" do
    let(:event) { Fabricate(:event) }
    let(:alice) { Fabricate(:user) }

    it "returns true is user has rsvp and is equal to true" do
      @rsvp = Rsvp.create(user_id: alice.id, event_id: event.id, going: true)
      expect(alice.is_going_to?(event)).to be_truthy
    end

    it "returns false is user does not have a rsvp or is false" do
      @rsvp = Rsvp.create(user_id: alice.id, event_id: event.id, going: false)
      expect(alice.is_going_to?(event)).to be_falsey
    end

    it "returns false if the rsvp doesn't exist" do
      expect(alice.is_going_to?(event)).to be_falsey
    end
  end

  describe "#upcoming_rsvps" do

    let(:user) { Fabricate(:user) }
    let(:event_1) { Fabricate(:event, date_time: DateTime.now )}
    let(:event_2) { Fabricate(:event, date_time: DateTime.now - 1.hour )}
    let(:event_3) { Fabricate(:event, date_time: DateTime.now + 1)}
    let(:event_4) { Fabricate(:event, date_time: DateTime.now + 2)}
    let(:event_5) { Fabricate(:event, date_time: DateTime.now + 3)}
    let(:event_6) { Fabricate(:event, date_time: (DateTime.now + 3) + 2.hours) }
    let(:event_7) { Fabricate(:event, date_time: 1.day.ago) }
    let(:event_8) { Fabricate(:event, date_time: 2.days.ago) }
    let(:event_9) { Fabricate(:event, date_time: 3.days.ago) }

    it "returns false when there are no upcoming rsvps" do
      expect(user.upcoming_rsvps).to be_falsey
    end

    it "returns an array of events where the 'date' is after today when the user has rsvps in the order of closest first by date" do
      rsvp_1 = Fabricate(:rsvp, user_id: user.id, event_id: event_1.id)
      rsvp_2 = Fabricate(:rsvp, user_id: user.id, event_id: event_2.id)
      rsvp_3 = Fabricate(:rsvp, user_id: user.id, event_id: event_3.id)
      rsvp_4 = Fabricate(:rsvp, user_id: user.id, event_id: event_4.id)
      rsvp_5 = Fabricate(:rsvp, user_id: user.id, event_id: event_5.id)
      rsvp_6 = Fabricate(:rsvp, user_id: user.id, event_id: event_6.id)
      rsvp_7 = Fabricate(:rsvp, user_id: user.id, event_id: event_7.id)
      rsvp_8 = Fabricate(:rsvp, user_id: user.id, event_id: event_8.id)
      rsvp_9 = Fabricate(:rsvp, user_id: user.id, event_id: event_9.id)

      expect(user.upcoming_rsvps).to match_array([event_1, event_2, event_3, event_4, event_5, event_6])
    end
  end

  describe "#is_admin_of?(group)" do
    let(:user) { Fabricate(:user) }
    let(:group) { Fabricate(:user) }

    it "returns false if user does not have a membership in the group" do
      expect(user.is_admin_of?(group)).to be_falsey
    end

    it "returns false if user has a membership for the group without the role of 'user" do
      Membership.create(group_id: group.id, user_id: user.id)
      expect(user.is_admin_of?(group)).to be_falsey
    end

    it "returns true if user has a membership of the group with the role of 'admin'" do
      Membership.create(group_id: group.id, user_id: user.id, role: 'admin')
      expect(user.is_admin_of?(group)).to be_truthy
    end
  end

  describe "#is_admin?" do
    it "returns true if the user has a role of 'user' " do
      admin = Fabricate(:admin)
      expect(admin.is_admin?).to be_truthy
    end

    it "returns false if the user doesn't have a role of 'user' " do
      regular_user = Fabricate(:user)
      expect(regular_user.is_admin?).to be_falsey
    end
  end

  describe "#can_modify_event?(event)" do

    it "returns true if the user is an admin" do
      admin = Fabricate(:admin)
      event = Fabricate(:event)
      expect(admin.can_modify_event?(event)).to be_truthy
    end

    it "returns true is the user is the creator of the event" do
      user = Fabricate(:user)
      event = Fabricate(:event, user_id: user.id)
      expect(user.can_modify_event?(event)).to be_truthy
    end

    it "returns false if the user doesn't have permission to edit the event" do
      user = Fabricate(:user)
      event = Fabricate(:event, user_id: user.id + 1)
      expect(user.can_modify_event?(event)).to be_falsey
    end
  end
end