# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :variation do
    option_set_name "MyString"
    option_name "MyString"
    gross_price "9.99"
    net_price "9.99"
    variant nil
    line_item nil
  end
end
