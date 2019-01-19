class ApplicationController < ActionController::API
  rescue_from ApiExceptions::CartError::ActivationFail, with: :render_error_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def render_error_response(err)
    render json: err_json(err), status: 200
  end

  def render_not_found(err)
    render json: err_json(err), status: 404
  end

  private

  def err_json(err)
    {
      status: "error",
      message: err
    }
  end

end
