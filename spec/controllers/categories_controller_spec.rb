require "spec_helper"

describe CategoriesController do
  describe  "GET new" do
    it "sets @category" do
      sign_in
      get :new
      expect(assigns[:category]).to be_instance_of(Category)
    end

    it_behaves_like "requires sign in" do
      let(:action) {get :new}
    end
  end

  describe "POST create" do

    context "with valid inputs" do

      let(:category_params) { Fabricate.attributes_for(:category) }

      before do
        sign_in
        post :create, category: category_params
      end

      it "redirects to the new category page" do
        expect(response).to redirect_to category_path(Category.first)
      end

      it "creates a new category" do
        expect(Category.count).to eq(1)
      end

      it "sets the success flash message" do
        expect(flash[:success]).to be_present
      end

    end

    context "with invalid inputs" do

      before do
        sign_in
        post :create, category: { name: "_" }
      end

      it "doesn't create the category" do
        expect(Category.count).to eq(0)
      end

      it "sets the flash danger message" do
        expect(flash[:danger]).to be_present
      end
      it "renders the :new template" do
        expect(response).to render_template :new
      end
    end

    it_behaves_like "requires sign in" do
      let(:action) { post :create, category: Fabricate.attributes_for(:category)}
    end
   end

  describe "GET show" do
    it "sets @category" do
      category = Fabricate(:category)
      get :show, id: category
      expect(assigns(:category)).to be_instance_of(Category)
    end
  end

  describe "GET index" do
    it "sets @category" do
      tech = Fabricate(:category, name: "Tech")
      music = Fabricate(:category, name: "Music")
      get :index
      expect(assigns(:categories)).to match_array([tech, music])
    end
  end

end