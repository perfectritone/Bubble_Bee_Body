json.array!(@salts) do |salt|
  json.extract! salt, :name, :description
  json.url salt_url(salt, format: :json)
end
