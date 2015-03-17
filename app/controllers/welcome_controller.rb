class WelcomeController < ApplicationController

  def profile
    @taggings = Tagging.all
    render 'profile', locals: { taggings: @taggings }
  end

  def search
    @blogs = Blog.search(params[:key])
    render 'search_result', locals: { blogs: @blogs}
  end


  def search_tag
    @blogs = Blog.search_tagged_blogs(params[:tagging_id])
    render 'search_result', locals: { blogs: @blogs }
  end

end
