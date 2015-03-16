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
    @tagging = Tagging.find(params[:tagging_id])
    @blogs = @tagging.tags.collect do |tag|
      if tag.tagable_type == 'Blog'
        tag.tagable
      else
        tag.tagable.blog
      end
    end
    @blogs.uniq!
    render 'tag_result', locals: { blogs: @blogs }
  end

end
