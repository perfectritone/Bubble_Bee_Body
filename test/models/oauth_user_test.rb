require "test_helper"

describe OauthUser do
  before do
    @oauth_user = OauthUser.new
  end

  it "must be valid" do
    @oauth_user.valid?.must_equal true
  end
end
