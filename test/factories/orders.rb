# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    user_name "MyString"
    gross_price "9.99"
    net_price "9.99"
  end
end
