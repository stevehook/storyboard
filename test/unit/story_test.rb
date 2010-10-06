require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  test "should be valid if mandatory attributes are specified" do
    story = Story.create(:title => 'test title', :description => 'test description', :estimate => 2)
    assert story.valid?
    assert story.errors[:title].none?
    assert story.errors[:description].none?
    assert story.errors[:estimate].none?
  end
  
  test "should be able to save a valid story" do
    story = Story.create(:title => 'test title', :description => 'test description', :estimate => 2)
    assert story.save
  end
  
  test "should be invalid if title missing" do
    story = Story.create(:description => 'test description', :estimate => 2)
    assert story.invalid?
    assert story.errors[:title].any?
    assert story.errors[:description].none?
    assert story.errors[:estimate].none?
  end
  
  test "should not be able to save an invalid story" do
    story = Story.create(:description => 'test description', :estimate => 2)
    assert !story.save
  end
  
  test "should be invalid if estimate missing" do
    story = Story.create(:title => 'test title', :description => 'test description')
    assert story.invalid?
    assert story.errors[:title].none?
    assert story.errors[:description].none?
    assert story.errors[:estimate].any?
  end
  
  test "should be invalid if description missing" do
    story = Story.create(:title => 'test title', :estimate => 2)
    assert story.invalid?
    assert story.errors[:title].none?
    assert story.errors[:description].any?
  end
  
  test "should be invalid if estimate is less than 1" do
    story = Story.create(:title => 'test title', :description => 'test description', :estimate => 0.99)
    assert story.invalid?
    assert story.errors[:estimate].any?
  end
  
  test "should be invalid if estimate is greater than 20" do
    story = Story.create(:title => 'test title', :description => 'test description', :estimate => 21)
    assert story.invalid?
    assert story.errors[:estimate].any?
  end
end
