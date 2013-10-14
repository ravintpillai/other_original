require 'spec_helper'

describe User do
  before { @user = User.create(name: "Someguy", email: "some@guy.com")}

  subject {@user}

  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should be_valid }
  
  describe "when name is not present" do
  	before {@user.name = ""}
  	it {should_not be_valid}
  end

  describe "when email is not present" do
  	before {@user.email = ""}
  	it {should_not be_valid}
  end

  describe "when name is too long" do
  	before {(@user.name = "h"*50)}
  	it {should_not be_valid}
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[rubbishemail@foo,com rubbishuser_at_foo.org rubbish@user@.com]
      addresses.each do |i|
        @user.email = i
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
  	it "should be valid" do
  		addresses = %w[hi@iamhere.com yo@yothisisme.com whatup@whatupdog.co.uk]
  		addresses.each do |i|
  			@user.email = i
  			expect(@user).to be_valid
  		end
  	end
  end

  describe "when email is already taken" do
  	it "should_not be valid" do
  		user_with_same_email = @user.dup
  		user_with_same_email.email = @user.email.upcase
  		user_with_same_email.save
  		expect(user_with_same_email).not_to be_valid
  		end
	end
end
