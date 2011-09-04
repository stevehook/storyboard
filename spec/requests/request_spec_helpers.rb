module RequestSpecHelpers
  def logon(project, release)
    # We need to 'grant' permissions UserSession#current_user in order to bypass authorisation rules
    # (Note: this will only work with the RackTest driver)
    user = User.create!(:name => 'Bob', :email => 'bob@nocompany.com', :password => 'secret', :password_confirmation => 'secret', 
                        :release => release, :project => project)
    session = UserSession.new({})
    session.login(user)
    UserSession.stub(:new).and_return(session)
  end
end
