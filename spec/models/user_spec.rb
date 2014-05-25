require 'spec_helper'

describe User do
  describe 'email' do
  	it 'should have an email address' do
  		user = User.create(email: "test@test.com", password: "12345678", password_confirmation: "12345678")
  		user.should be_valid
  	end

  	it 'should be in email format' do
  		user = User.create(email: "not_a_real_email", password: "12345678", password_confirmation: "12345678")
  		user.should_not be_valid
  	end

  	it 'should be unique' do
  		user1 = User.create(email: "user1@email.com", password: "12345678", password_confirmation: "12345678")
  		user2 = User.create(email: "user1@email.com", password: "12345678", password_confirmation: "12345678")
  		user2.should_not be_valid
  	end

  	it 'should be in proper email format' do
  		user = User.create(email: "blahblahblahblah.com", password: "12345678", password_confirmation: "12345678")
  		user.should_not be_valid
  	end
  end
end
