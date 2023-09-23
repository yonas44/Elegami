class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    respond_to do |format|
      if current_user
        format.html { redirect_to root_path, notice: 'Signed in successfully.' }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(
            'flash_container',
            partial: 'partials/shared/flash',
            locals: { errors: ['Login Failed, invalid credentials!'], success: nil }
          )
        end
      end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
