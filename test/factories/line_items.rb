# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :line_item do
    product_name "MyString"
    product_number "MyString"
    supplier_number "MyString"
    brand "MyString"
    gross_price "9.99"
    net_price "9.99"
    quantity 1
  end
end
