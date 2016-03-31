FactoryGirl.define do
  factory :operation do
    # categories
    # company

    sequence(:invoice_num) { |n| n }
    invoice_date Faker::Date.between(2.days.ago, Date.today)
    amount Faker::Number.decimal(2)
    operation_date Faker::Date.between(2.days.ago, Date.today)
    kind Faker::Name.title
    status Faker::Name.title
  end
end
