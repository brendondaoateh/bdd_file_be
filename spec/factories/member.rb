# frozen_string_literal: true

FactoryBot.define do
  factory :member do
    association :organisation
    member_name { 'Member 1' }
  end
end
