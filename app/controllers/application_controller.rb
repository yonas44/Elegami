class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |_exception|
    respond_to do |format|
      format.html do
        flash[:errors] = ['You are unauthorized!']
        redirect_back fallback_location: projects_path
      end
      format.turbo_stream do
        render turbo_stream: turbo_stream.append(
          'flash_container', partial: 'partials/shared/flash',
                             locals: { success: nil, errors: ['You are unauthorized!'] }
        )
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name])
  end
end
