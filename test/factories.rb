FactoryGirl.define do
  factory :shop do
    name 'foo'
    sequence(:link) { |n| "bar#{n}" }
  end
end
