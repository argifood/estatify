class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?


  protected
  #devise_parameter_sanitizer.for(:account_update) << :fullname << :phone_number << :description << :email << :password << :fb_link << :twitter_link << :lkdin_link << :gplus_link << :skype_link
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end
end
