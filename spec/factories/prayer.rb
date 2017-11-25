FactoryBot.define do
  factory :prayer do
    user
    sequence(:text) { |n| "This is prayer #{n}" }
    tag_list 'one two three'
  end
end
