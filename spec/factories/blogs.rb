FactoryGirl.define do
  factory :blog do
    association :user
    title "MyString"
    description "MyString"
    values "tag1,tag2"

    factory :invalid_blog do
      title nil
      description nil
    end

  end
end
