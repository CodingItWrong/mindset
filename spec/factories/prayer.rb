FactoryGirl.define do
  factory :prayer do
    user
    sequence :text { |n| "This is prayer #{n}" }
  end
end
