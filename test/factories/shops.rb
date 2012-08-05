FactoryGirl.define do
  factory :shop do
    name 'foo'
    sequence(:link) { |n| "bar#{n}" }
    locale 'en'

    factory :shop_full do
      login_text 'baz'
      password_text 'foobar'
      text 'lorem ipsum dolor sit amet'
      currency 'points'
      border_style '#000'
      link_style '#ff9'
      custom_style 'body { background-color: #eee; }'
      receipt_text 'lorem ipsum dolor sit amet'
      correspondent 'foo@example.com'
      shipping_price 123.45
      free_shipping_over 543.21
    end
  end
end
