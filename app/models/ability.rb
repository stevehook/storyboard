class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all if !user.nil?
    can :read, :all if !user.nil?
  end
end
