json.array!(@patients) do |patient|
  json.extract! patient, :id, :full_name, :email, :ammount, :comments
  json.url patient_url(patient, format: :json)
end
