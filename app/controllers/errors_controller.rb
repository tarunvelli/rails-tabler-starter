class ErrorsController < ActionController::Base
  layout 'error'

  def show
    status_code = params[:code] || 500
    flash.alert = "Status #{status_code}"
    render status_code.to_s, status: status_code
  end
end
