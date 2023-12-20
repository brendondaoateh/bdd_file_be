# frozen_string_literal: true

module FileServices
  class Create < Base
    def call(file_params, member_id)
      file = OpenAiFile.from_openai_file(file_params, member_id)
      file.save
      file
    end
  end
end
