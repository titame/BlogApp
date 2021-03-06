require 'spec_helper'
include ControllerMacros

describe CommentsController do
  before :each do
    @user = login_user
    @blog = create(:blog, user: @user)
  end


  describe "GET #new" do
    it "it assigns new instance of comment" do
      get :new, blog_id: @blog
      expect(assigns(:comment)).to be_a_new(Comment)
    end

    it "it renders template new for comment" do
      get :new, blog_id: @blog
      expect(response).to render_template(:new)
    end
  end

  describe "GET #index" do
    it "assigns selected blog's comments to @comments" do
      @comment = create(:comment, blog: @blog, user: @user)
      get :index, blog_id: @blog
      expect(assigns(:comments)).to include @comment
    end

    it "it renders index page of selected blog's comments" do
      get :index, blog_id: @blog
      expect(response).to render_template(:index)
    end
  end

  describe "GET #edit" do
    it "renders edit template for comment if user is authorized" do
      @comment = create(:comment, blog: @blog, user: @user)
      get :edit, blog_id: @blog, id: @comment
      expect(response).to render_template(:edit)
    end

    it "redirects to users profile page if user is unauthorized to edit " do
      @others_comment = create(:comment)
      get :edit, blog_id: @blog, id: @others_comment
      expect(response).to redirect_to(root_url)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates comment by current user and for current blog" do
        expect{
          post :create, blog_id: @blog, comment: attributes_for(:comment)
          }.to change(Comment, :count).by(1)
      end

      it "rediects to created comments page" do
        post :create, blog_id: @blog, comment: attributes_for(:comment)
        expect(response).to redirect_to(@blog)
      end
    end

    context "with invalid params" do
      it "do not create comment of current user" do
        expect{ post :create, blog_id: @blog, comment: attributes_for(:invalid_comment)
          }.to change(Comment, :count).by(0)
      end

      it "renders teplate new" do
        post :create, blog_id: @blog, comment: attributes_for(:invalid_comment)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "POST #update" do
    before :each do
      @comment = create(:comment, blog: @blog, user: @user)
      @new_comment =create(:comment, post: "NewPost")
    end

    context "with valid params" do
      it "updates comment of current user" do
        post :update, blog_id: @blog, id: @comment, comment: { post: @new_comment.post }
        @comment.reload
        expect(@comment.post).to eq @new_comment.post
      end

      it "rediects to updated comments page" do
        post :update, blog_id: @blog, id: @comment, comment: { post: @new_comment.post }
        expect(response).to redirect_to(@blog)
      end
    end

    context "with invalid params" do
      it "do not update comment of current user" do
        post :update, blog_id: @blog, id: @comment, comment: {post: ""}
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "POST #destroy" do
    it "destroy comment" do
      @comment = create(:comment, blog: @blog, user: @user)
      expect{ post :destroy, blog_id: @blog, id: @comment
        }.to change(Comment, :count).by(-1)
    end
  end
end
