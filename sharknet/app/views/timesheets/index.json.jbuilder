json.array!(@timesheets) do |timesheet|
  json.extract! timesheet, :status, :period
  json.url timesheet_url(timesheet, format: :json)
end
