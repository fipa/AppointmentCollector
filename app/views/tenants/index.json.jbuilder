json.array!(@tenants) do |tenant|
  json.extract! tenant, :id, :full_name, :email, :ammount, :comments
  json.url tenant_url(tenant, format: :json)
end
