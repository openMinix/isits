json.array!(@activities) do |activity|
  json.extract! activity, :type_activity, :description, :work_hours, :extra
  json.url activity_url(activity, format: :json)
end
