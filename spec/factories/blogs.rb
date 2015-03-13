FactoryGirl.define do
  factory :blog do
    association :user
    title "MyString"
    description "MyString"

    factory :invalid_blog do
      title nil
      description nil
    end

  end
end
