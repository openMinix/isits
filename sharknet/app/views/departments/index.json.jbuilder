json.array!(@departments) do |department|
  json.extract! department, :dept_name, :division_id
  json.url department_url(department, format: :json)
end
