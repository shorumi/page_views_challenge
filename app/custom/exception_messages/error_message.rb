# frozen_string_literal: true

module ExceptionMessages
  module NotFoundFile
    class << self
      def message
        {
          status_code: 404,
          message: 'There is no valid Log File, please provide one!'
        }
      end
    end
  end
end
