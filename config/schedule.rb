# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
every 1.day, at: '1:30 am' do
  rake 'batch:delete_old_tokens'
end
every 1.day, at: '2:00 am' do
  rake 'batch:take_off_old_events'
end
every 1.day, at: '2:30 am' do
  rake 'batch:remove_old_users'
end
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
