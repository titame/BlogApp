FactoryGirl.define do
  factory :comment do
    association :user
    association :blog
    post "MyText"
    values "tag1,tag2"

    factory :invalid_comment do
      post nil
    end
  end
end
