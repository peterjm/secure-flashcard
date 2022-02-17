# frozen_string_literal: true

FactoryBot.define do
  factory :card do
    question { "What is 1 + 1?" }
    answer { "2" }
  end
end
