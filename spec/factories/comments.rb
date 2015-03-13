FactoryGirl.define do
  factory :comment do
    association :user
    association :blog
    post "MyText"

    factory :invalid_comment do
      post nil
    end
  end
end
