# frozen_string_literal: true
FactoryBot.define do
  factory :thought do
    user
    sequence(:text) { |n| "This is thought #{n}" }
    tag_list { 'one two three' }
  end
end
