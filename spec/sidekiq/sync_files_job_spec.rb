# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SyncFilesJob, type: :job do
  let(:member) { create(:member) }

  describe '#perform' do
    it 'has data in DB same as in OpenAI' do
      VCR.use_cassette('list_files_valid') do
        create(:open_ai_file, member: member)
        create(:open_ai_file, member: member)
        create(:open_ai_file, member: member)
        described_class.new.perform(member.id)

        expected_response = [
          { "file_id": 'file-DKQD4iZvYfaqQ6Pfx8Yq7CZh', "bytes": 2830,
            "remotely_created_at": '2023-12-11T11:33:16.000Z',
            "filename": 'sample.pdf', "object": 'file', "purpose": 'assistants' },
          { "file_id": 'file-0xnOZNQwNqWzPHFl3yeOIHgK', "bytes": 3028,
            "remotely_created_at": '2023-12-11T04:38:18.000Z',
            "filename": 'sample.pdf', "object": 'file', "purpose": 'assistants' }
        ]

        db_files = OpenAiFile.all
        expect(db_files.length).to eq(expected_response.length)
        db_files.each_with_index do |element, index|
          expect(element.object).to eq(expected_response[index][:object])
          expect(element.file_id).to eq(expected_response[index][:file_id])
          expect(element.filename).to eq(expected_response[index][:filename])
          expect(element.bytes).to eq(expected_response[index][:bytes])
          expect(element.purpose).to eq(expected_response[index][:purpose])
          expect(element.remotely_created_at).to eq(expected_response[index][:remotely_created_at])
        end
      end
    end
  end
end
