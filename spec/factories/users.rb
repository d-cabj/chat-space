FactoryGirl.define do
  factory :user do
    id                      1
    name                    "abe"
    email                   'aaaa@aaa.com'
    password                "00000000"
    password_confirmation   "00000000"
    created_at              {Faker::Time.between(2.days.ago, Time.now, :all)}
  end
end
