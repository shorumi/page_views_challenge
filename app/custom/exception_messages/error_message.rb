# frozen_string_literal: true

module ExceptionMessages
  module DefaultError
    class << self
      def error_message(error)
        {
          message: 'An unexpected error occurred',
          status_code: 505,
          error: error.message
        }
      end
    end
  end
end
