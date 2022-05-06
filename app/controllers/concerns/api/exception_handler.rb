module Api::ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from Pundit::NotAuthorizedError, with: :render403
    rescue_from ActiveRecord::RecordNotFound, with: :render404
    rescue_from StandardError, with: :render500
  end

  private

  def render400(exception = nil, messages = nil)
    render_error(400, 'Bad Request', exception&.message, *messages)
  end

  def render401(exception = nil, messages = nil)
    render_error(401, 'Not Authenticated', exception&.message, *messages)
  end

  def render403(exception = nil, messages = nil)
    render_error(403, 'Forbidden', exception&.message, *messages)
  end

  def render404(exception = nil, messages = nil)
    render_error(404, 'Record Not Found', exception&.message, *messages)
  end

  def render500(exception = nil, messages = nil)
    render_error(500, 'Internal Server Error', exception&.message, *messages)
  end

  def render_error(code, message, *error_messages)
    response = {
      message: message,
      errors: error_messages.compact
    }

    render json: response, status: code
  end
end