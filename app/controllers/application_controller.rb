class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  def after_sign_up_path_for(resource)
    ballot_boxes_path
  end
  
  def after_sign_in_path_for(resource)
    ballot_boxes_path
  end
  
  def after_sign_out_path_for(resource)
    ballot_boxes_path
  end
end

