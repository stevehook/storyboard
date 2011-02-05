require 'rubygems'
require 'spec_helper'

describe Story do
  before(:each) do
  end
  
  after(:each) do
  end

  it "should be valid if mandatory attributes are specified" do
    story = Story.create(:title => 'test title', :description => 'test description', :estimate => 2)
    story.valid?.should be_true
    story.errors[:title].none?.should be_true
    story.errors[:description].none?.should be_true
    story.errors[:estimate].none?.should be_true
  end
  
  it "should be able to save a valid story" do
    story = Story.create(:title => 'test title', :description => 'test description', :estimate => 2)
    story.save.should be_true
  end

  it "should be invalid if title missing" do
    story = Story.create(:description => 'test description', :estimate => 2)
    story.invalid?.should be_true
    story.errors[:title].any?.should be_true
    story.errors[:description].none?.should be_true
    story.errors[:estimate].none?.should be_true
  end

  it "should not be able to save an invalid story" do
    story = Story.create(:description => 'test description', :estimate => 2)
    !story.save.should be_false
  end
  
  it "should be invalid if estimate missing" do
    story = Story.create(:title => 'test title', :description => 'test description')
    story.invalid?.should be_true
    story.errors[:title].none?.should be_true
    story.errors[:description].none?.should be_true
    story.errors[:estimate].any?.should be_true
  end
  
  it "should be invalid if description missing" do
    story = Story.create(:title => 'test title', :estimate => 2)
    story.invalid?.should be_true
    story.errors[:title].none?.should be_true
    story.errors[:description].any?.should be_true
  end
  
  it "should be invalid if estimate is less than 1" do
    story = Story.create(:title => 'test title', :description => 'test description', :estimate => 0.99)
    story.invalid?.should be_true
    story.errors[:estimate].any?.should be_true
  end
  
  it "should be invalid if estimate is greater than 20" do
    story = Story.create(:title => 'test title', :description => 'test description', :estimate => 21)
    story.invalid?.should be_true
    story.errors[:estimate].any?.should be_true
  end
end