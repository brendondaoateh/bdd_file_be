# frozen_string_literal: true

module OpenaiFileServices
  class Upload < Base
    def call(purpose, file_path)
      BddOpenai::FileClient.new(ENV['OPENAI_API_KEY']).upload_file(purpose, file_path)
    end
  end
end
