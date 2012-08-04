FactoryGirl.define do
  factory :shop do
    name 'foo'
    sequence(:link) { |n| "bar#{n}" }
    locale 'en'
  end

  factory :category do
    name 'foo'
    shop
  end
end
