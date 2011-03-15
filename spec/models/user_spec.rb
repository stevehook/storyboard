require 'spec_helper'

describe User do
  context "when creating a new user with a name, email and password" do
    let(:user) { User.create(:name => 'Fred', :email => 'fred@nocompany.com', :password => 'secret') }
    it "should be valid" do
      user.valid?.should be_true
      user.errors[:name].any?.should be_false
      user.errors[:email].any?.should be_false
    end

    it "password_hash should not be set" do
      user.password_hash.should be_nil
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
      user = User.create(:name => 'Fred', :password => 'secret')
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
end
