# spec/factories/report.rb
FactoryGirl.define do
  factory :report do
  	report_type "QR-7"
		humanname "Quarterly Report"
		messages { [FactoryGirl.create(:message)] }
  end

  factory :message do
    message_type "QR-7"
		message_text "message text message text message text"
  end
end