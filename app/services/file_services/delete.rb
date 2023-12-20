# frozen_string_literal: true

module FileServices
  class Delete < Base
    def call(file_id)
      OpenAiFile.destroy(file_id)
    end
  end
end
