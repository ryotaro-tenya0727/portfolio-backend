class ApplicationController < ActionController::API
  include Pundit::Authorization
  include Api::ExceptionHandler
end
