# spec/factories/contacts.rb
FactoryGirl.define do
  factory :reminder do
    name "test reminder"
    message_text "test reminder"
    program { FactoryGirl.create(:program) }
	report { program.report.new }
    # recipients {[FactoryGirl.create(:recipient)]}

  end
end