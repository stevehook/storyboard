require 'spec_helper'

describe Team do
  context 'when creating a new team with a scrum master' do
    let(:scrum_master) { User.create(:name => 'Arthur', :email => 'arthur@nocompany.com') }
    let(:team) { Team.create(:name => 'Team 1') }
    
    it "the scrum master should be a member of the team" do
      team.scrum_master = scrum_master
      team.before_save
      scrum_master.team.should_not be_nil
      scrum_master.team.should == team
      team.members.length.should == 1
    end
  end

  context 'when soft deleting a user' do
    let(:arthur) { User.create(:name => 'Arthur', :email => 'arthur@nocompany.com') }

    it "a newly created user should not be destroyed?" do
      arthur.destroyed?.should be_false
    end

    it "a deleted user should be destroyed?" do
      arthur.delete
      arthur.destroyed?.should be_true
    end

    it "a restored user should not be destroyed?" do
      arthur.delete
      arthur.restore
      arthur.destroyed?.should be_false
    end
  end
end
