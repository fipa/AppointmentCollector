json.array!(@clients) do |client|
  json.extract! client, :id, :full_name, :email, :ammount, :comments
  json.url client_url(client, format: :json)
end
