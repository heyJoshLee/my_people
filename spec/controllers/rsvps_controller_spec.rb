require "spec_helper"

describe RsvpsController do
  describe "POST create" do
    let(:event) { Fabricate(:event) }
    let(:alice) { Fabricate(:user) }
    let(:rsvp_parmas) { Fabricate.attributes_for(:rsvp, event_id: event.id)}
    
    it "creates an rsvp" do
      sign_in(alice)
      post :create, event_id: event.slug, rsvp: rsvp_parmas, format: :js
      expect(Rsvp.count).to eq(1)
    end

    it "is associated with the current_user" do
      sign_in(alice)
      post :create, event_id: event.slug, rsvp: rsvp_parmas, format: :js
      expect(Rsvp.first.user_id).to eq(alice.id)
    end

    it_behaves_like "requires sign in" do
      let(:action) { post :create, event_id: event.slug, rsvp: rsvp_parmas}
    end
  end


end