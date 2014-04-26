require 'spec_helper'

describe User do
  before { @user = User.create(name: "Someguy", email: "some@guy.com",
  password: "password", password_confirmation: "password")}

  subject {@user}

  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:password_digest)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}

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

  describe "when password is blank" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                     password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password is not the same as password_confirmation" do
    before {@user.password_confirmation = "mismatch"}
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
end
