json.array!(@sheetfiles) do |sheetfile|
  json.extract! sheetfile, :day
  json.url sheetfile_url(sheetfile, format: :json)
end
