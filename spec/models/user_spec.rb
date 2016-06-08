require "spec_helper"

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:email)}
  it { should have_secure_password }

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
end