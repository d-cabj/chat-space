FactoryGirl.define do
  factory :group do
    id                  1
    name                "abe"
    created_at          {Faker::Time.between(2.days.ago, Time.now, :all)}
  end
end
