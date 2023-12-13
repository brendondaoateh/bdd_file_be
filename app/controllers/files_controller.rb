# frozen_string_literal: true

class FilesController < ApplicationController
  before_action :set_open_ai_file, only: %i[show]

  # GET /files
  def index
    @open_ai_files = OpenAiFile.all

    render json: @open_ai_files
  end

  # GET /files/1
  def show
    render json: @open_ai_file
  end

  # POST /files
  def create
    purpose = params[:purpose]
    render json: { error: 'Missing purpose parameter' }, status: :unprocessable_entity unless purpose.present?

    file = params[:file]
    render json: { error: 'Missing file parameter' }, status: :unprocessable_entity unless file.present?

    # TODO call API to create file
    # TODO save file to database

    render json: { request: { purpose: purpose, file: file } }, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_open_ai_file
    @open_ai_file = OpenAiFile.find(params[:id])
  end
end
