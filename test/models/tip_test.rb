require 'test_helper'

describe Tip do
  # let(:tip) { FactoryGirl.create(:tip) }

  before do
    @tip = Tip.new(title: "Ambiguous Title", content: "That title was just there to throw you off.")
  end

  it { @tip.must_respond_to :title }
  it { @tip.must_respond_to :content }

  describe "must have a title and contents" do
    it "but it doesn't have either" do
      @tip.title = nil
      @tip.content = nil
      @tip.wont_be :valid?
    end

    it "but it only has a title" do
      @tip.content = nil
      @tip.wont_be :valid?
    end

    it "but it only has content" do
      @tip.title = nil
      @tip.wont_be :valid?
    end
  end

  describe "should contain both the title and the content in the string representation." do
    it do
      tip_string = @tip.to_s
      tip_string.must_be_instance_of String
      tip_string.must_match /#{Regexp.quote(@tip.title)}\s+#{Regexp.quote(@tip.content)}/
    end
  end
end