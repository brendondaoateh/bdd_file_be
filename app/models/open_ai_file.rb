# frozen_string_literal: true

class OpenAiFile < ApplicationRecord
  belongs_to :member
  has_one :organisation, through: :member

  # @param [BddOpenai::Mapper::File] openai_file
  # @param [String] member_id
  # @return [OpenAiFile]
  def self.from_openai_file(openai_file, member_id)
    new(
      member_id: member_id,
      object: openai_file.object,
      file_id: openai_file.id,
      purpose: openai_file.purpose,
      filename: openai_file.filename,
      bytes: openai_file.bytes,
      remotely_created_at: Time.at(openai_file.created_at).strftime('%Y-%m-%d %H:%M:%S.%6N')
    )
  end
end
