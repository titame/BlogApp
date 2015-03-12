require 'spec_helper'

describe BlogsController do
  login_user

  describe "GET #new" do
    it "it assigns new instance of blog" do
      get :new
      expect(assigns(:blog)).to be_a_new(Blog)
    end

    it "it renders template new for blog" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #index" do
    it "assigns current users blogs to @blogs" do
      @blog = create(:blog, user: @user)
      get :index
      expect(assigns(:blogs)).to include @blog
    end

    it "it renders index page of current users blogs" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #edit" do
    it "renders edit template for blog if user is authorized" do
      @blog = create(:blog, user: @user)
      get :edit, id: @blog
      expect(response).to render_template(:edit)
    end

    it "redirects to users profile page if user is unauthorized to edit " do
      @others_blog = create(:blog)
      get :edit, id: @others_blog
      expect(response).to redirect_to(root_url)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates blog of current user" do
        expect{ post :create, blog: attributes_for(:blog)
          }.to change(Blog, :count).by(1)
      end

      it "rediects to created blogs page" do
        post :create, blog: attributes_for(:blog)
        expect(response).to redirect_to(@user.blogs.last)
      end
    end

    context "with invalid params" do
      it "do not create blog of current user" do
        expect{ post :create, blog: attributes_for(:invalid_blog)
          }.to change(Blog, :count).by(0)
      end

      it "renders teplate new" do
        post :create, blog: attributes_for(:invalid_blog)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "POST #update" do
    context "with valid params" do
      it "updates blog of current user" do
        @blog = create(:blog, user: @user)
        post :update, id: @blog, blog: {title: "NewBlog"}
        @blog.reload
        expect(@blog.title).to eq "NewBlog"
      end

      it "rediects to updated blogs page" do
        @blog = create(:blog, user: @user)
        post :update, id: @blog, blog: {title: "NewBlog"}
        expect(response).to redirect_to(@blog)
      end
    end

    context "with invalid params" do
      it "do not update blog of current user" do
        @blog = create(:blog, user: @user)
        post :update, id: @blog, blog: {title: ""}
        expect(response).to render_template(:edit)
      end
    end
  end

    describe "POST #destroy" do
      it "destroy blog" do
        @blog = create(:blog, user: @user)
        expect{ post :destroy, id: @blog
          }.to change(Blog, :count).by(-1)
      end
    end
end
