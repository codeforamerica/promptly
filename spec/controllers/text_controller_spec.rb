require 'spec_helper'

describe TextController do
	it "checks if there is a valid incoming phone number" do
		get :receive_text_message, :phone => 9196361635
		# flash[:alert].response
		expect(response.body).to include(9196361635.to_s)
	end
end
