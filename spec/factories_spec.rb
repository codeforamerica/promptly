require 'spec_helper'

FactoryGirl.factories.map(&:name).each do |factory_name|
  describe "The #{factory_name} factory" do
     it 'is valid' do
      build(factory_name).should be_valid
     end
  end
end