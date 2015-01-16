class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :null_session
before_filter :authenticate_user_from_token!

  respond_to :json, :html

  private
  def authenticate_user_from_token!
    user_email = request.env['HTTP_X_ANDROID_EMAIL']
    user = user_email && User.find_by_email(user_email)

    if user && Devise.secure_compare(user.authentication_token, request.env['HTTP_X_ANDROID_TOKEN'])
      sign_in user, store: false
    end
  end

  # The path used after sign up. You need to overwrite this method
  # in your own RegistrationsController.
  def after_sign_in_path_for(resource)
    persons_im_path
  end
end
