# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :variant do
    net_price "9.99"
    gross_price "9.99"
    option nil
    product nil
  end
end
