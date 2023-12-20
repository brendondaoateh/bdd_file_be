# frozen_string_literal: true

module OpenaiFileServices
  class Delete < Base
    def call(file_id)
      BddOpenai::FileClient.new(ENV['OPENAI_API_KEY']).delete_file(file_id)
    end
  end
end
