require 'spec_helper'

describe Team do
  context 'when creating a new team with a scrum master' do
    let(:scrum_master) { User.create(:name => 'Arthur', :email => 'arthur@nocompany.com') }
    let(:team) { Team.create(:name => 'Team 1') }
    
    it "the scrum master should be a member of the team" do
      puts scrum_master.team
      team.scrum_master = scrum_master
      team.before_save
      scrum_master.team.should_not be_nil
      scrum_master.team.should == team
      # TODO: Fix this assertion...
      # team.members.length.should == 1
    end
  end
end
