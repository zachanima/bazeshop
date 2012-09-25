# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :option do
    name "MyString"
    position 1
    option_group nil
  end
end
