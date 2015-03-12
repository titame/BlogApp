FactoryGirl.define do
  factory :blog do
    title "MyString"
    description "MyString"
    tags "MyText"

    factory :invalid_blog do
      title nil
      description nil
    end
  end

end
