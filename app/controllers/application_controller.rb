class ApplicationController < ActionController::API
  rescue_from ApiExceptions::CartError::ActivationFail, with: :render_error_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ApiExceptions::CartError::InvalidQuantity, with: :render_bad_request
  rescue_from ApiExceptions::CartError::CartModificationFail, with: :render_bad_request

  def render_error_response(err)
    render json: err_json(err), status: 200
  end

  def render_not_found(err)
    render json: err_json(err), status: 404
  end

  def render_bad_request(err)
    render json: err_json(err), status: 400
  end

  private

  def err_json(err)
    {
      status: "error",
      message: err
    }
  end

end
