class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    about_path
  end

  def after_sign_out_path_for(resource)
    about_path
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name, :introduction])
    # devise_parameter_sanitizer.permit(:account_update, keys: [:email, :name, :introduction])
  end

end
