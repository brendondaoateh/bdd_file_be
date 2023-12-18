# frozen_string_literal: true

module FileServices
  class List < Base
    def call
      OpenAiFile.all
    end
  end
end
