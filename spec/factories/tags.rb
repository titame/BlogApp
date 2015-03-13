FactoryGirl.define do
  factory :tag do
    values "MyText"
  end

  factory :blog_tag do
    association :tagable, factory: :blog
  end

  factory :comment_tag do
    association :tagable, factory: :comment
  end

end
