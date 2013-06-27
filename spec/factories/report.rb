FactoryGirl.define do
  factory :report do
  	report_type "QR-7"
		humanname "Quarterly Report"
		program { FactoryGirl.create(:program)}
  end
end