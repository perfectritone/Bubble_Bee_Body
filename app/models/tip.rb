class Tip < ActiveRecord::Base
  validates_presence_of :title, :content

  after_save :post_to_facebook

  private
    def post_to_facebook
      oauth_access_token = nil

      @graph = Koala::Facebook::API.new(oauth_access_token)
      
      profile = @graph.get_object("me")
      accounts = @graph.get_connections("me", "accounts")

      page_from_user = nil
      accounts.each do |account| 
        page_from_user = account if account['name'] == "Bubble Bee Body"
      end

      page_id = page_from_user['id']

      post_response = @graph.put_connections(page_id, 'feed', message: self.to_s)

      if post_response.has_key? 'id'
        self.fb_id = post_response['id']
        self.save
      else
        flash.now[:error] = 'Could not post to Facebook.'
      end
    end

    def to_s
      "#{self.title}\r\n\r\n#{self.content}"
    end
end