class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all

    #Product
    can [:edit, :destroy, :update], Product, :user_id => user.id
    can [:create, :charge, :download_sample], Product
  end
end
