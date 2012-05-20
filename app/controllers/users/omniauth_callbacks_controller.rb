class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def yammer
    # You need to implement the method below in your model
    # logger.debug(request.env["omniauth.auth"].inspect)
    @user = User.find_for_yammer_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Yammer"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.yammer_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end

