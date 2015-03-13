class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :set_blog, only: [:index, :new, :edit, :create, :destroy]

  def index
    @comments = Comment.where(blog: @blog)
  end

  def new
    @comment = @blog.comments.new
  end

  def edit
    unless authorized_user?(@comment)
      redirect_to root_url, notice: "You are not authorised to edit this comment!"
    end
  end

  def create
    @comment = @blog.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @blog, notice: 'comment successfully added'
    else
      render :new
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.blog, notice: 'comment successfully updated'
    else
      render :edit
    end
  end

  def destroy
    if @comment.destroy
      redirect_to @blog, notice: "comment on blog #{@blog.title} was successfully deleted"
    end
  end

private
  def comment_params
    params.require(:comment).permit(:post, :values)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_blog
    @blog = Blog.find(params[:blog_id])
  end

end
