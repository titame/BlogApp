module TaggingSearch
  extend ActiveSupport::Concern

  module ClassMethods
    def search_tagged_blogs(tagging_id)
      @tagging = Tagging.find(tagging_id)
      @blogs = @tagging.tags.collect do |tag|
        if tag.tagable_type == 'Blog'
          tag.tagable
        else
          tag.tagable.blog
        end
      end
      @blogs.uniq
    end
  end

end
