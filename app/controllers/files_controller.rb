# frozen_string_literal: true

require 'bdd_openai'

class FilesController < ApplicationController
  before_action :set_open_ai_file, only: %i[show destroy]

  # GET /files
  def index
    service = FileServices::List.new
    files = service.call
    render json: files
  end

  # GET /files/1
  def show
    file_id = params[:id]
    service = FileServices::Get.new
    service.call(file_id)
    render json: files
  end

  # POST /files
  def create
    params.require(%i[member_id purpose file])

    member_id = params[:member_id]
    file_path = params[:file]

    allowed_purposes = %w[fine-tune assistants]
    purpose = params[:purpose]
    unless allowed_purposes.include?(purpose)
      render json: { error: "Invalid purpose, expect: #{allowed_purposes.join(', ')}" }, status: :unprocessable_entity
      return
    end

    file_response = BddOpenai::FileClient.new(ENV['OPENAI_API_KEY']).upload_file(purpose, file_path)
    return handle_error_response(file_response) if file_response.is_a?(BddOpenai::ErrorResponse)

    open_ai_file = OpenAiFile.from_openai_file(file_response, member_id)
    if open_ai_file.save
      render json: open_ai_file, status: :created, location: open_ai_file
    else
      render json: open_ai_file.errors, status: :unprocessable_entity
    end
  end

  # DELETE /files/1
  def destroy
    file_id = @open_ai_file.file_id
    file_response = BddOpenai::FileClient.new(ENV['OPENAI_API_KEY']).delete_file(file_id)

    return handle_error_response(file_response) if file_response.is_a?(BddOpenai::ErrorResponse)

    @open_ai_file.destroy
    render json: { message: 'success' }, status: :ok
  end

  private

  # @param error_response [BddOpenai::ErrorResponse]
  # @return [ActionController::Response]
  def handle_error_response(error_response)
    case error_response.code
    when 'invalid_api_key'
      render json: { message: 'invalid api key' },
             status: :unauthorized
    else
      render json: { message: 'internal error', error: error_response },
             status: :internal_server_error
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_open_ai_file
    @open_ai_file = OpenAiFile.find(params[:id])
  end
end
