require 'spec_helper'

describe User do
  context "when creating a new user with a name, email and password" do
    let(:user) { User.create(:name => 'Fred', :email => 'fred@nocompany.com', :password => 'secret') }
    it "should be valid" do
      user.valid?.should be_true
      user.errors[:name].any?.should be_false
      user.errors[:email].any?.should be_false
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
end
