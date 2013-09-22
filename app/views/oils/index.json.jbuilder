json.array!(@oils) do |oil|
  json.extract! oil, :name, :description
  json.url oil_url(oil, format: :json)
end
