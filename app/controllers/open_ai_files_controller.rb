class OpenAiFilesController < ApplicationController
  before_action :set_open_ai_file, only: %i[ show update destroy ]

  # GET /open_ai_files
  def index
    @open_ai_files = OpenAiFile.all

    render json: @open_ai_files
  end

  # GET /open_ai_files/1
  def show
    render json: @open_ai_file
  end

  # POST /open_ai_files
  def create
    @open_ai_file = OpenAiFile.new(open_ai_file_params)

    if @open_ai_file.save
      render json: @open_ai_file, status: :created, location: @open_ai_file
    else
      render json: @open_ai_file.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /open_ai_files/1
  def update
    if @open_ai_file.update(open_ai_file_params)
      render json: @open_ai_file
    else
      render json: @open_ai_file.errors, status: :unprocessable_entity
    end
  end

  # DELETE /open_ai_files/1
  def destroy
    @open_ai_file.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_open_ai_file
      @open_ai_file = OpenAiFile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def open_ai_file_params
      params.fetch(:open_ai_file, {})
    end
end
