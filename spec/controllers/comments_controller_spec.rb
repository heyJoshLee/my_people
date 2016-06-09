require "spec_helper"

describe CommentsController do
  describe "POST comment" do
    context "commenting on a group" do
      let(:group) { Fabricate(:group) }
      let(:alice) { Fabricate(:user) }
      let(:comment_params) { Fabricate.attributes_for(:comment, body: "Hi there") }

      before do
        sign_in(alice)
      end

      it "creates at comment" do
        post :create, group_id: group.slug, object_type: "Group", comment: comment_params, format: :js
        expect(Comment.count).to eq(1)
      end

      it "associates the comment with the post" do
        post :create, group_id: group.slug, object_type: "Group", comment: comment_params, format: :js
        expect(Group.first.comments.first.body).to eq("Hi there")
      end

      it "associates the comment with the current" do
        patch :create, group_id: group.slug, object_type: "Group", comment: comment_params, format: :js
        expect(Comment.first.creator.id).to eq(alice.id)
      end

      it_behaves_like "requires sign in" do
        let(:action) {  patch :create, group_id: group.slug, object_type: "Group", comment: comment_params, format: :js }
      end
    end


  end



end