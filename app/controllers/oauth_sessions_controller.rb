class OauthSessionsController < ApplicationController
  def create
    user = OauthUser.from_omniauth(env["omniauth.auth"])
    session[:oauth_user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:oauth_user_id] = nil
    redirect_to new_tip_path
  end
end