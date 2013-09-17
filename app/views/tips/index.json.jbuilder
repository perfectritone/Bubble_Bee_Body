json.array!(@tips) do |tip|
  json.extract! tip, :title, :content
  json.url tip_url(tip, format: :json)
end
