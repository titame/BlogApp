class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can [:edit, :preview], Blog, user_id: user.id
      can [:edit, :destroy], Comment, user_id: user.id
    end
  end

end
