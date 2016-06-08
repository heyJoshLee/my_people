require "spec_helper"

describe Group do 

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:creator_id) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:zip_code) }
  it { should validate_presence_of(:category_id) }
  it { should belong_to(:creator)}
  it { should belong_to(:category)}

  describe "#members" do
    let(:alice) { Fabricate(:user) }
    let(:bob) { Fabricate(:user) }
    let(:charile) { Fabricate(:user) }
    let(:dylan) { Fabricate(:user ) }
    let(:group) { Fabricate(:group) }
    let(:members) { [] }
    before do
      [alice, bob, charile, dylan].each_with_index do |user, index|
        Membership.create(user_id: user.id, group_id: group.id, created_at: (index + 1).days.ago )
        members << user
      end
    end
    it "returns an array of users in the order of last joined" do
      expect(group.members).to match_array(members)
    end

end


end