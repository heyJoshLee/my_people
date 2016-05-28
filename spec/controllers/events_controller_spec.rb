require "spec_helper"

describe EventsController do

  describe "GET new" do

    it "sets @event" do
      log_in
      get :new
      expect(assigns(:event)).to be_instance_of(Event)
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end
  end

  describe "POST create" do
    context "with valid credentials" do

      let(:event_params) { Fabricate.attributes_for(:event) }
      let(:alice) { Fabricate(:user)}

      before do
        log_in(alice)
        post :create, event: event_params
      end

      it "redirects to the event page" do
        expect(response).to redirect_to event_path(Event.first)
      end

      it "sets the flash message" do
        expect(flash[:success]).to be_present
      end

      it "creates the event" do
        expect(Event.count).to eq(1)
      end

      it "sets the creator of the event to the current_user" do
        expect(Event.first.creator).to eq(alice)
      end

    end

    context "with invalid credentials" do

      let (:invalid_params) { {name: "Hi there"} }

      before do
        log_in
        post :create, event: invalid_params
      end

      it "renders :new" do
        expect(response).to render_template :new
      end

      it "doesn't create the the event" do
        expect(Event.all.count).to eq(0)
      end

      it "sets the flash message" do
        expect(flash[:danger]).to be_present
      end
    end

    it_behaves_like "requires sign in" do
      let(:action) { post :create, event: { name: "hi there" } }
    end
  end

  describe "GET show" do

    it "sets event with valid event" do
      event = Fabricate(:event)
      get :show, id: event.id
      expect(assigns(:event)).to eq(event)
    end

    it "redirects to can't find page for invalid event" do
      get :show, id: "123"
      expect(response).to redirect_to event_not_found_path
    end
  end
  
end