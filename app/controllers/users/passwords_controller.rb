class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  def new
    # super
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.append('flash_container', partial: 'partials/shared/flash', locals: { success: nil, errors: ['Unauthorzed for test version']})
      }
    end
  end

  # POST /resource/password
  def create
    # super
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.append('flash_container', partial: 'partials/shared/flash', locals: { success: nil, errors: ['Unauthorzed for test version']})
      }
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
