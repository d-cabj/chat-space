FactoryGirl.define do
  factory :message do
    id                  1
    body                "abe"
    message_img         "hoge.jpg"
    group_id            1
    user_id             1
    created_at          {Faker::Time.between(2.days.ago, Time.now, :all)}
  end
end
