FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "test#{n}@gmail.com"}
    password "testpassword123"

    factory :invalid_user do
      email nil
      password nil
    end
  end
end
