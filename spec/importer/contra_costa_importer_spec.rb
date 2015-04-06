require 'spec_helper'

describe ContraCostaImporter do
  before :each do
     @message = FactoryGirl.create(:message)
     @organization = FactoryGirl.create(:organization)
     @file_path = "./spec/files/ccc_appt_20140715.csv"
   end
  describe "#build_reminder" do
    it "builds the reminder from a csv" do
      @user = FactoryGirl.create(:user, email: 'andy@postcode.io')
      @count = Reminder.all.count
      importer = ContraCostaImporter.new(@file_path)
      expect(Reminder.all.count).to be > @count
    end
  end
end
