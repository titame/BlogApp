FactoryGirl.define do
  factory :picture do
    img_url "MyString"

    factory :invalid_picture do
      img_url nil
    end

    factory :user_picture do
      association :imagiable, factory: :user
    end

    factory :blog_picture do
      association :imagiable, factory: :blog
    end

  end

end
