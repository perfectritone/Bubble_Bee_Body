FactoryGirl.define do
  factory :tip do
    sequence(:title) { |n| "Title #{n}" }
    sequence(:content) do |n| 
      "This tip is all about the number #{n} and how it can assist with your momentary fleshy existence."
    end
  end
end