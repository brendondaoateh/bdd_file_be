# frozen_string_literal: true

module Files
  class API < Grape::API
    # helpers Pundit::Authorization

    version 'v1', using: :path
    format :json
    prefix :api

    resource :files do
      desc 'return list of files'
      get do
        SyncFilesJob.perform_async

        service = ::FileServices::List.new
        service.call
      end

      desc 'return file by id'
      params do
        requires :id, type: String, desc: 'id'
      end
      get ':id' do
        service = ::FileServices::Get.new
        service.call(params[:id])
      end

      desc 'upload file'
      params do
        requires :member_id, type: String, allow_blank: false
        requires :purpose, type: String, values: %w[fine-tune assistants]
        requires :file, type: String, allow_blank: false, desc: 'file_path'
      end
      post do
        member_id = params[:member_id]
        file_path = params[:file]
        purpose = params[:purpose]

        file_response = ::OpenaiFileServices::Upload.new.call(purpose, file_path)
        error!(file_response) if file_response.is_a?(BddOpenai::ErrorResponse)

        saved_file = ::FileServices::Create.new.call(file_response, member_id)
        if saved_file.errors.any?
          error!(saved_file.errors, 500)
        else
          saved_file
        end
      end

      desc 'delete file'
      params do
        requires :id, type: String, desc: 'id'
      end
      delete ':id' do
        id = params[:id]
        file = ::FileServices::Get.new.call(id)

        file_response = ::OpenaiFileServices::Delete.new.call(file.file_id)
        error!(file_response) if file_response.is_a?(BddOpenai::ErrorResponse)

        result = ::FileServices::Delete.new.call(id)
        if result
          { message: 'file deleted successfully' }
        else
          error!({ message: 'file deleted failed' }, 500)
        end
      end
    end

    private

    # @param error_response [BddOpenai::ErrorResponse]
    # @return [ActionController::Response]
    def handle_error_response(error_response)
      case error_response.code
      when 'invalid_api_key'
        [{ message: 'invalid api key' }, 401]
      else
        [{ message: 'internal error', error: error_response }, 500]
      end
    end
  end
end
