# frozen_string_literal: true

module ExceptionMessages
  module LogFileNotFoundErrorMessage
    class << self
      def error_message(error)
        {
          message: 'Please insert a valid logfile at ./log_files/ directory',
          status_code: 404,
          error: error.message
        }
      end
    end
  end
end
