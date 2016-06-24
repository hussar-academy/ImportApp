FactoryGirl.define do
  factory :company do
    sequence(:name) { |n| "company #{n}" } 
  end
end
