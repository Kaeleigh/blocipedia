FactoryGirl.define do
  factory :wiki do
    title "Testing"
    body "Words"
    private false
    user
  end
end
