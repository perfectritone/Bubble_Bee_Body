class Tip < ActiveRecord::Base
  validates_presence_of :title, :content

  # after_save :post_to_facebook

  def to_s
    <<-STRING
#{self.title}

#{self.content}
    STRING
  end

  private
    # def post_to_facebook
    #   app_id = Bbb::Application.config.app_id
    #   app_secret = ENV['FB_APP_SECRET']
    #   # callback_url = nil
    #   @oauth = Koala::Facebook::OAuth.new(app_id, app_secret)

    #   @oauth.get_user_info_from_cookies(cookies)

    #   @graph = Koala::Facebook::API.new(oauth_access_token)

    #   profile = @graph.get_object("me")
    #   accounts = @graph.get_connections("me", "accounts")

    #   # Find the corresponding Page to be posted on
    #   page_from_user = nil
    #   accounts.each do |account| 
    #     page_from_user = account if account['name'] == "Bubble Bee Body"
    #   end

    #   page_id = page_from_user['id']

    #   # Post the post to facebook wall
    #   post_response = @graph.put_connections(page_id, 'feed', message: self.to_s)

    #   if post_response.has_key? 'id'
    #     self.fb_id = post_response['id']
    #     self.save
    #   else
    #     flash.now[:error] = 'Could not post to Facebook.'
    #   end
    # end
end