namespace :batch do
  desc "Deletes old tokens"
  task delete_old_tokens: :environment do
    tokens = Token.where('created_at < ?', 48.hours.ago)
    tokens.each { |t| t.destroy }
  end
end
