require 'spec_helper'

describe Tag do
  describe 'name' do
  	it 'should have a tag name' do
  		tag = Tag.create(name: "javasript")
  		tag.should be_valid
  	end
  end
end
