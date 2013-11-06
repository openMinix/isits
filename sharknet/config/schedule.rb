# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# Uncomment for logging
#set :output,'./cronOutput.txt'
set :environment, "development"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

#run "whenever --update-crontab -set='environment=development'" and "service cron stop/start" after changing the file
every :month do
  runner "User.create_timesheets"
end
