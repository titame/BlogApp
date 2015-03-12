FactoryGirl.define do
  factory :comment do
    post "MyText"

    factory :invalid_comment do
      post nil
    end
  end

end
