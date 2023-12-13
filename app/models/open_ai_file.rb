# frozen_string_literal: true

class OpenAiFile < ApplicationRecord
  belongs_to :member
  has_one :organisation, through: :member
end
