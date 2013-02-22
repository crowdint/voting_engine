module VotingApp
  module ApiErrorHandling
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::UnknownAttributeError, ArgumentError do |exception|
        respond_with_error(exception, 400)
      end

      rescue_from ActiveRecord::RecordNotFound do |exception|
        respond_with_error(exception, 404)
      end

      rescue_from ActiveRecord::RecordInvalid do |exception|
        respond_with_error(exception, 422, errors: exception.record.errors.messages)
      end

      rescue_from RuntimeError do |exception|
        respond_with_error(exception, 500)
      end
    end

    private

    def respond_with_error(exception, code, errors = {})
      render json: {error: exception.class.to_s,
                    message: exception.to_s,
                    errors: errors},
             status: code
    end
  end
end
