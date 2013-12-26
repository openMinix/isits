json.array!(@user_jobs) do |user_job|
  json.extract! user_job, :title
  json.url user_job_url(user_job, format: :json)
end
