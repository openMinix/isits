json.array!(@clients) do |client|
  json.extract! client, :client_name
  json.url client_url(client, format: :json)
end
