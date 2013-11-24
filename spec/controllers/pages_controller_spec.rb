require 'spec_helper'
require "cancan/matchers"

describe PagesController do

	it "can view index" do
		get :splash
		assert_template :splash # render the template since he should have access
	end

	it "can view hsa" do
		get :hsa
		assert_template :hsa
	end

	it "can view documents" do
		get :documents
		assert_template :documents
	end

end
