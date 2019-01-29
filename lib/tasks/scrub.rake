require Rails.root.join('./app/models/meeting/extract_phone.rb').to_s

namespace :scrub do
  desc 'extract and store phone number'
  task phone: :environment do
    Meeting.each do |meeting|
      ExtractPhone.extract! meeting
    end
  end
end
