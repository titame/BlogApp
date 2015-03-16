class WelcomeController < ApplicationController

  def profile
    @taggings = Tagging.all
    render 'profile', locals: { taggings: @taggings }
  end

  def search
    @blog_ids = Comment.search_blog_ids(params[:key])
    @blogs = Blog.search(params[:key], @blog_ids )
    @taggings = Tagging.search(params[:key])
    render 'search_result', locals: { blogs: @blogs, taggings: @taggings}
  end


  def search_tag
    debugger
    @tagging = Tagging.find(params[:tagging_id])
    @blogs = @tagging.tags.collect do |tag|
      if tag.tagable_type == 'Blog'
        tag.tagable
      else
        tag.tagable.blog
      end
    end
    @blogs.uniq!
    render 'tag_result', locals: { blogs: @blogs, comments: @comments }
  end

end


    # @blog_ids = Comment.tagged_comments_blog_ids('Comment', params[:tagging_id])
    # @blogs = Blog.find_tagged_blogs('Blog', params[:tagging_id], blog_ids)
