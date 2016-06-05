require "spec_helper"

describe CommentsController do
  describe "POST comment" do
    context "commenting on a group" do
      let(:group) { Fabricate(:group) }
      let(:alice) { Fabricate(:user) }
      let(:comment_params) { Fabricate.attributes_for(:comment, body: "Hi there") }

      before do
        sign_in(alice)
        post :create, group_id: group.slug, comment: comment_params
      end

      it "creates at comment" do
        expect(Comment.count).to eq(1)
      end

      it "associates the comment with the post" do
        expect(Group.first.comments.first.body).to eq("Hi there")
      end

      it "associates the comment with the current" do
        expect(Comment.first.creator.id).to eq(alice.id)
      end
    end

    it_behaves_like "requires sign in" do
      let(:action) { post :create, id: Fabricate(:group).id, comment: Fabricate.attributes_for(:comment) }
    end

  end



end