# frozen_string_literal: true

module OpenaiFileServices
  class List < Base
    def call
      BddOpenai::FileClient.new(ENV['OPENAI_API_KEY']).list_files
    end
  end
end
