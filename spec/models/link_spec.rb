require 'spec_helper'

describe Link do
  describe 'title' do
  	it 'should have a title' do
  		link = Link.create(url: "www.google.com")
  		link.should_not be_valid
  	end

  	it 'should have a minimum of 2 characters' do
  		link = Link.create(title: "Q", url: "wwww.google.com")
  		link.should_not be_valid
  	end
  end

  describe 'url' do
  	it 'should have a url' do
  		link = Link.create(title: "test")
  		link.should_not be_valid
  	end

  	it 'should have a minimum of 5 characters' do
  		link = Link.create(title: "test", url: "q.co")
  		link.should_not be_valid
  	end
  end
end
