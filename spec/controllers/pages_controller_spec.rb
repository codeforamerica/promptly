require 'spec_helper'
require "cancan/matchers"

describe PagesController, :type => :controller do

	it "can view index" do
		get :home
		assert_template :home # render the template since he should have access
	end

end
