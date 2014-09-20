json.array!(@calendars) do |calendar|
  json.extract! calendar, :id, :name, :calendar_key, :user_id, :comments
  json.url calendar_url(calendar, format: :json)
end
