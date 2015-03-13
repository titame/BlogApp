require 'spec_helper'
include ControllerMacros

describe BlogsController do
  before :each do
    @user = login_user
    @blog = create(:blog, user: @user)
  end

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
        debugger
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
    before :each do
      @new_blog =create(:blog, title: "NewBlog")
    end

    context "with valid params" do
      it "updates blog of current user" do
        debugger
        post :update, id: @blog, blog: {title: @new_blog.title}
        @blog.reload
        expect(@blog.title).to eq @new_blog.title
      end

      it "rediects to updated blogs page" do
        post :update, id: @blog, blog: {title: @new_blog.title}
        expect(response).to redirect_to(@blog)
      end
    end

    context "with invalid params" do
      it "do not update blog of current user" do
        post :update, id: @blog, blog: {title: ""}
        expect(response).to render_template(:edit)
      end
    end
  end

    describe "POST #destroy" do
      it "destroy blog" do
        expect{
          post :destroy, id: @blog
        }.to change(Blog, :count).by(-1)
      end
    end
end
