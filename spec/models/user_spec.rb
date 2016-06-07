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
end