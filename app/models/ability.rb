class Ability
  include CanCan::Ability

  def initialize user
    if user.present?
      if user.admin?
        can :manage, :all
      else
        can [:read, :create, :total_price], Booking, user_id: user.id
        can [:create, :destroy], Like, user_id: user.id
        can :read, [Location, Tour]
        can [:create, :update], Review, user_id: user.id
      end
    else
      can :read, [Location, Tour]
    end
  end
end
