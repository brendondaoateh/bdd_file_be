# frozen_string_literal: true

class Member < ApplicationRecord
  belongs_to :organisation
  has_many :open_ai_files
end
