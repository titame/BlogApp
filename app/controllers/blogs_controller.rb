class BlogsController < ApplicationController
  before_action :authenticate_admin, only: [:list_blogs, :populate_blogs]
  before_action :set_blog, only: [:edit, :show, :preview, :update, :transition, :destroy]

  def new
    @blog = Blog.new
  end

  def index
    @blogs = current_user.blogs
  end

  def edit
    unless authorized_user?(@blog)
      redirect_to root_url, notice: "You are not authorised to edit this blog"
    end
  end

  def show
  end

  def preview
    unless authorized_user?(@comment)
      redirect_to root_url, notice: "You are not authorised to preview this blog"
    end
  end

  def transition
    if @blog.update(status: params[:status])
      redirect_to published_blogs_path, notice: "Blog status changed to #{@blog.status}"
    else
      redirect_to root_url, notice: "Sorry.Unable to change status of blog!"
    end
  end

  def create
    @blog = current_user.blogs.new(blog_params)
    if @blog.save
      redirect_to @blog, notice: 'Blog successfully saved'
    else
      render :new
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to @blog, notice: 'blog was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    if @blog.destroy
      redirect_to @blog, notice: 'blog was successfully deleted'
    end
  end

  def published_blogs
    if current_user.admin?
      @blogs = Blog.all
    else
      @blogs = Blog.publishable_blogs
    end
    if @blogs.empty?
      redirect_to root_url, notice: "Sorry.No blogs available!"
    end
  end

  def list_blogs
    @blogs = Blog.all.order(created_at: :desc)
  end

  def populate_blogs
    @user = User.find(params[:id])
    @blogs = @user.blogs
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :description, :tags)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def authenticate_admin
    unless current_user.admin?
      redirect_to root_url, notice: "You are not authorised to view this page!"
    end
  end

end
