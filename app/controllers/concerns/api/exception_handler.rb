module Api::ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :render500
    rescue_from NoMethodError, with: :render500
    rescue_from Aws::S3::Errors::ServiceError, with: :render500
    rescue_from ActiveRecord::RecordNotDestroyed, with: :render500
    rescue_from ActiveRecord::RecordNotFound, with: :render404
    rescue_from Pundit::NotAuthorizedError, with: :render403
    rescue_from JWT::VerificationError, with: :render401
    rescue_from JWT::DecodeError, with: :render401
    rescue_from ActiveRecord::RecordInvalid, with: :render400
  end

  private

  def render500(exception = nil)
    logger.error exception
    render_error(500, 'Internal Server Error', exception&.message)
  end

  def render404(exception = nil)
    logger.error exception
    render_error(404, 'Record Not Found', exception&.message)
  end

  def render403(exception = nil)
    render_error(403, 'Forbidden', exception&.message)
  end

  def render401(exception = nil)
    logger.error exception
    render_error(401, 'Not Authenticated', exception&.message)
  end

  def render400(exception = nil)
    logger.error exception
    render_error(400, 'Bad Request', exception&.message)
  end

  def render_error(code, message, *error_messages)
    response = {
      message: message,
      errors: error_messages
    }

    render json: response, status: code
  end
end
