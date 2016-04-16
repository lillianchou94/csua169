

FactoryGirl.define do
  factory :user do
    user_name "User A"
    user_email  "a@gmail.com"
    organization "CSUA"
    is_active true
  end
end