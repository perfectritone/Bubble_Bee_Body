require 'test_helper'

describe TipsController do
  before do
    @controller = TipsController.new
  end

  describe "should contain both the page id and the post id." do
    it do
      page_id = 1000
      post_id = 1001
      @controller.instance_eval{ get_post_url(1000, 1001) }
      url = @controller.instance_eval{ @get_post_url }.must_be_instance_of String
      url.must_be_instance_of String
      url.must_match /https:\/\/www\.facebook\.com\/#{page_id}\/posts\/#{post_id}/
    end
  end  
end