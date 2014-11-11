# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category_user_order_date, :class => 'CategoryUserOrderDates' do
    category nil
    user nil
    order_date "2014-11-11"
  end
end
