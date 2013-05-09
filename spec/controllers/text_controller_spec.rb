require 'spec_helper'

describe TextController do
	it "checks if there is a valid incoming phone number" do
		get :receive_message
	end
end
