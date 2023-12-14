# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Files', type: :request do
  let(:member) { create(:member) }

  describe 'GET /files' do
    it 'returns array of files' do
      open_ai_file1 = create(:open_ai_file, member: member)
      open_ai_file2 = create(:open_ai_file, member: member)
      expected_response = [open_ai_file1, open_ai_file2]

      get '/files'
      expect(response).to have_http_status(:success)

      response_body = JSON.parse(response.body)
      expect(response_body).to be_an(Array)
      expect(response_body.length).to eq(expected_response.length)
      response_body.each_with_index do |element, index|
        expect(element.to_json).to eq(expected_response[index].to_json)
      end
    end
  end

  describe 'GET /files/1' do
    it 'returns a file' do
      open_ai_file = create(:open_ai_file, member: member)

      get "/files/#{open_ai_file.id}"
      expect(response).to have_http_status(:success)

      response_body = JSON.parse(response.body)
      expect(response_body.to_json).to eq(open_ai_file.to_json)
    end
  end

  describe 'POST /files' do
    it 'creates a file' do
      VCR.use_cassette('upload_file_valid') do
        post '/files', params: {
          member_id: member.id,
          purpose: 'assistants',
          file: 'spec/fixtures/sample.pdf'
        }
        expect(response).to have_http_status(:success)
        create_response_body = JSON.parse(response.body)

        get "/files/#{create_response_body['id']}"
        show_response_body = JSON.parse(response.body)

        expect(create_response_body.to_json).to eq(show_response_body.to_json)
      end
    end
  end

  describe 'DELETE /files/1' do
    it 'deletes a file' do
      VCR.use_cassette('delete_file_valid') do
        open_ai_file = create(:open_ai_file, member: member)

        delete "/files/#{open_ai_file.id}"
        expect(response).to have_http_status(:success)

        get '/files'
        index_response_body = JSON.parse(response.body)
        expect(index_response_body).to be_an(Array)
        expect(index_response_body.length).to eq(0)
      end
    end
  end
end
