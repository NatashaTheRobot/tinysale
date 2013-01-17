class PasswordsController < Devise::PasswordsController
  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)

    if successfully_sent?(resource)
      return render :json => {:success => true}
    else
      return render :json => {:success => false}
    end
  end
end