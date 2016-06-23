FactoryGirl.define do
  factory :operation do
    sequence(:invoice_num) { |n| "invoice_num #{n}" } 
    invoice_date Date.today
    operation_date Date.today
    sequence(:amount) { |n| n } 
    sequence(:status) { |n| "status #{n}" } 
    sequence(:kind) { |n| "kind #{n}" } 
  end
end
