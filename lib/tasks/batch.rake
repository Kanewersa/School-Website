namespace :batch do
  desc "Deletes old tokens"
  task delete_old_tokens: :environment do
    tokens = Token.where('created_at < ?', 48.hours.ago)
    tokens.each { |t| t.destroy }
  end
  task take_off_old_events: :environment do
    announcements = Event.where(('valid_date != null') && 'valid_date < ?', 2.hours.ago )
    announcements.each { |a|
      a.important = 0
      if a.announcement
        a.status = 2 # set status to 'old'
      end
      a.save
    }
  end
end
