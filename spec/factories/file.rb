# frozen_string_literal: true

FactoryBot.define do
  factory :open_ai_file do
    association :member
    file_id { 'file-DKQD4iZvYfaqQ6Pfx8Yq7CZh' }
    bytes { '2830' }
    remotely_created_at { '2023-12-15 03:08:18' }
    filename { 'sample.pdf' }
    object { 'file' }
    purpose { 'assistants' }
  end
end
