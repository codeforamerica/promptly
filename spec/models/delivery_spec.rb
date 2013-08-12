require 'spec_helper'

describe Delivery do
	it "has a valid factory" do
    FactoryGirl.create(:delivery).should be_valid
  end

  describe 'batch delivery import' do
  	context 'given an existing reminder' do
  		it 'assigns the proper reminder_id'
	  end
	  context 'given an new reminder' do
	  	it 'creates a new reminder'
	  	it 'assigns the proper reminder_id'
	  end
	  it "receives uploaded data"
	  it "adds new records from spreadsheet"
	end
end
