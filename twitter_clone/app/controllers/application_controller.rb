# frozen_string_literal: true

# aplication controler handle parameters permitted by application
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[full_name user_name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[full_name user_name])
  end
end
