class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include Pagy::Backend

  def after_sign_in_path_for(resource_or_scope)
    users_path
    #current_user
  end

  protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_in, keys: [:role])
      devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
      devise_parameter_sanitizer.permit(:account_update, keys: [:role])
    end

  private

    def user_not_authorized
      redirect_to request.referrer || root_path, notice: "You are not authorized to perform this action."
    end
end
