class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found(exception)
    render json: { message: "Requested #{exception.model} Record does not exist." },
           status: :not_found
  end
end
