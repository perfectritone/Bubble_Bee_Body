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
end