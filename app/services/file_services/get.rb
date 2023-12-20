# frozen_string_literal: true

module FileServices
  class Get < Base
    def call(id)
      OpenAiFile.find(id)
    end
  end
end
