FactoryGirl.define do
  factory :shop do
    name 'foo'
    sequence(:link) { |n| "bar#{n}" }
    locale 'en'
  end
end
