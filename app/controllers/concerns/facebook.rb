module Facebook
  extend ActiveSupport::Concern

  # Get the facebook url to redirect the user to to ask for permissions.
  # Params: app id, redirect back url(optional).
  def get_token_url(app_id, redirect_back_url, scope = [])
    "https://graph.facebook.com/oauth/authorize?client_id=#{app_id}&"\
    "redirect_uri=#{redirect_back_url}&scope=#{scope.join(',')}&"\
    "response_type=token"
  end

end