require "spec_helper"

describe Event do

  it {should belong_to(:creator)}
  it {should belong_to(:category)}
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:street_address) }
  it { should validate_presence_of(:zip_code) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:date_time) }

  describe "#all_going" do
    let(:event) { Fabricate(:event) }
    let(:rsvp_1) { Fabricate(:rsvp, event_id: event.id, created_at: 1.day.ago )}
    let(:rsvp_2) { Fabricate(:rsvp, event_id: event.id, created_at: 2.days.ago )}
    let(:rsvp_3) { Fabricate(:rsvp, event_id: event.id, created_at: 3.days.ago )}
    let(:rsvp_4) { Fabricate(:rsvp, event_id: event.id, created_at: 4.days.ago )}

    it "returns an array containing all rsvps that are going sorted by date" do
      expect(event.all_going).to match_array([rsvp_1, rsvp_2, rsvp_3, rsvp_4])
    end
  end

  describe "#all_not_going" do
    let(:event) { Fabricate(:event) }
    let(:rsvp_1) { Fabricate(:rsvp, event_id: event.id, updated_at: 1.day.ago, going: false )}
    let(:rsvp_2) { Fabricate(:rsvp, event_id: event.id, updated_at: 2.days.ago, going: false )}
    let(:rsvp_3) { Fabricate(:rsvp, event_id: event.id, updated_at: 3.days.ago, going: false )}
    let(:rsvp_4) { Fabricate(:rsvp, event_id: event.id, updated_at: 4.days.ago, going: false )}

    it "returns an array containing all rsvps that are not going sorted by date" do
      expect(event.all_not_going).to match_array([rsvp_1, rsvp_2, rsvp_3, rsvp_4])
    end
  end

  describe "#description_truncated" do
    it "should return the first 140 characters from the description" do
      event = Fabricate(:event)
      expect(event.description_truncated).to eq(event.description[0..140])
    end
  end
end