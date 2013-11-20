json.array!(@divisions) do |division|
  json.extract! division, :div_name
  json.url division_url(division, format: :json)
end
