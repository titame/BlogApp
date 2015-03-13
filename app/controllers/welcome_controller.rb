class WelcomeController < ApplicationController

  def profile
    @taggings = Tagging.all
    render 'profile', locals: { taggings: @taggings }
  end

  def search
    @blogs = Blog.search(params[:key])
    @comments = Comment.search(params[:key])
    render 'search_result', locals: { blogs: @blogs, comments: @comments}
  end


  def search_tag
    @blogs = Blog.where(id: Tag.select('tagable_id').where("tagging_id= ? AND tagable_type= 'Blog'",params[:tag_id]))
    @comments = Comment.where(id: Tag.select('tagable_id').where("tagging_id= ? AND tagable_type= 'Comment'",params[:tag_id]))
    render 'search_result', locals: { blogs: @blogs, comments: @comments}
  end

end
