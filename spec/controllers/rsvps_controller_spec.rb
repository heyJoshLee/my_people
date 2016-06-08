require "spec_helper"

describe RsvpsController do
  describe "POST create" do
    let(:event) { Fabricate(:event) }
    let(:alice) { Fabricate(:user) }
    let(:rsvp_parmas) { Fabricate.attributes_for(:rsvp, event_id: event.id)}
    
    it "creates an rsvp" do
      post :create, event_id: event.id, rsvp: rsvp_parmas
    end
    it "is associated with the current_user"
  end


end