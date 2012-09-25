# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :option_set do
    name "MyString"
    optional false
    position 1
  end
end
