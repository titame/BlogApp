class WelcomeController < ApplicationController

  def profile
    @taggings = Tagging.all
    render 'profile', locals: { taggings: @taggings }
  end

  def search
    @blogs = Blog.search(params[:key])
    @comments = Comment.search(params[:key])
    @taggings = Tagging.search(params[:key])
    render 'search_result', locals: { blogs: @blogs, comments: @comments, taggings: @taggings}
  end


  def search_tag
    @blogs = Blog.find_tagged_blogs('Blog', params[:tagging_id])
    @comments = Comment.find_tagged_comments('Comment', params[:tagging_id])
    render 'tag_result', locals: { blogs: @blogs, comments: @comments }
  end

end
