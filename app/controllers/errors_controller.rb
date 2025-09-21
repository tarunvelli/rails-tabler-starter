class ErrorsController < ActionController::Base
  VALID_CODES = %w[404 422 500].freeze
  layout "plain"

  def show
    status_code = "500" unless VALID_CODES.include?(code)
    flash.alert = "Status #{status_code}"
    render status_code.to_s, status: status_code
  end
end
