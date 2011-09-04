require 'spec_helper'

describe User do
  context "when creating a new user with a name, email, password and password_confirmation" do
    let(:user) { User.new(:name => 'Fred', :email => 'fred@nocompany.com', :password => 'secret', :password_confirmation => 'secret') }
    it "should be valid" do
      user.valid?.should be_true
      user.errors[:name].any?.should be_false
      user.errors[:email].any?.should be_false
    end

    it "password_hash should not be set" do
      user.password_hash.should be_nil
    end
  end

  context "when creating a new user with a name, email, password and (non-matching) password_confirmation" do
    let(:user) { User.new(:name => 'Fred', :email => 'fred@nocompany.com', :password => 'secret', :password_confirmation => 'not_secret') }
    it "should be valid" do
      user.valid?.should be_false
    end
  end

  context "when creating a new user with a name, email, password and missing password_confirmation" do
    let(:user) { User.new(:name => 'Fred', :email => 'fred@nocompany.com', :password => 'secret') }
    it "should be valid" do
      user.valid?.should be_false
      user.errors[:password].any?.should be_true
      user.errors[:password_confirmation].any?.should be_true
    end
  end

  context "when creating a new user with a name but no email" do
    let(:user) { User.create(:name => 'Fred', :password => 'secret') }
    it "should be invalid" do
      user.valid?.should be_false
      user.errors[:name].any?.should be_false
      user.errors[:email].any?.should be_true
    end
  end

  context "when encrypting a password" do
    let(:user) { 
      user = User.new(:name => 'Fred', :password => 'secret')
      user.encrypt_password
      user
    }
    it "password_hash should be set" do
      user.password_hash.should_not be_nil
    end

    it "password_salt should be set" do
      user.password_salt.should_not be_nil
    end
  end

  context "when authenticating user" do
    before(:each) do
      # Stub the User.find_by_email method
      user = User.new(:name => 'Fred', :password => 'secret')
      user.encrypt_password
      User.stub(:find_by_name) do |email| 
        email == 'Fred' ? user : nil
      end
      User.stub(:find_by_email) do |email| 
        email == 'fred@no.com' ? user : nil
      end
    end

    it "should pass valid credentials by name" do
      user = User.authenticate('Fred', 'secret')
      user.should_not be_nil
    end

    it "should pass valid credentials by email" do
      user = User.authenticate('fred@no.com', 'secret')
      user.should_not be_nil
    end

    it "should reject missing user" do
      user = User.authenticate('Bob', 'secret')
      user.should be_nil
    end

    it "should reject wrong password" do
      user = User.authenticate('Fred', 'wrong')
      user.should be_nil
    end
  end
end
